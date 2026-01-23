import numpy as np
from scipy.spatial import cKDTree


def IDWInterp(
    lon_orig, lat_orig, values_orig, lon_target, lat_target, 
    power=2, k=5, max_dist=10.0
):
    """
    Inverse Distance Weighting (IDW) interpolation.
    Ignore the NaN values and support extrapolation automatically.
    The nearest points searching method is K-D Tree.

    Input:
        lon_orig, lat_orig:
            Original meshgrid of longitude & latitude (2-D)
            `lon_orig` & `lat_orig` should share the same shape.

        values_orig:
            Original values at the meshgrid (2-D)
            `values_orgi` should share the same shape with
            `lon_orig` & `lat_orig`.

        lon_target, lat_target:
            Target meshgrid of longitude & latitude (2-D)
            `lon_target` & `lat_target` should share the same shape.

        power:
            The power used to calculate distance (default 2)

        k:
            The number of original points used to interpolate
            for one target point (default 5)

        max_dist:
            The maxium searching distance (in degree, default 10.0)
            Any point beyond the distance would be set to NaN

    Return:
        The interpolated values in the shape of target
        longtitude & latitude

    Requirements:
        numpy
        scipy
    
    Code by Chen Huizhong, 2025-06-15.
    """
    # Shape check
    assert lon_orig.shape == lat_orig.shape == values_orig.shape, (
        "inconsistent original data input shape"
    )
    assert lon_target.shape == lat_target.shape, "Target mesh shape is inconsistent"

    # Ravel original data and mask NaN
    points_orig = np.column_stack([lon_orig.ravel(), lat_orig.ravel()])
    values_flat = values_orig.ravel()
    valid_mask = ~np.isnan(values_flat)
    points_valid = points_orig[valid_mask]
    values_valid = values_flat[valid_mask]

    # Use the KDTree method to accelerate searching
    tree = cKDTree(points_valid)

    # Ravel the target meshgrid
    points_target = np.column_stack([lon_target.ravel(), lat_target.ravel()])

    # Search for the nearest points
    distances, indices = tree.query(points_target, k=k, distance_upper_bound=max_dist)

    # Calculate the inverse distance weight
    weights = np.zeros_like(distances)
    # original points beyond the `max_dist`
    valid_dist_mask = distances < np.inf
    weights[valid_dist_mask] = 1.0 / (distances[valid_dist_mask] + 1e-12) ** power
    weights = weights / np.sum(weights, axis=1)[:, np.newaxis]

    # Interpolation and NaN mask
    interp_values = np.sum(values_valid[indices] * weights, axis=1)
    interp_values[~np.any(valid_dist_mask, axis=1)] = np.nan

    return interp_values.reshape(lon_target.shape)
