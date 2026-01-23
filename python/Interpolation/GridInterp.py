import numpy as np
from scipy.interpolate import griddata

def GridInterp(
    lon_orig,
    lat_orig,
    values_orig,
    lon_target,
    lat_target,
    method="cubic",
    extrapolate=False,
):
    """
    Robust interpolation for 2-D geographic space using cubic interpolation.
    Ignores NaNs and works on irregular input data.

    Input:
        lon_orig, lat_orig:
            Original meshgrid of longitude & latitude (2-D)
            lon_orig & lat_orig should share the same shape.

        values_orig:
            Original values at the meshgrid (2-D)
            values_orgi should share the same shape with
            lon_orig & lat_orig.

        lon_target, lat_target:
            Target meshgrid of longitude & latitude (2-D)
            lon_target & lat_target should share the same shape.

        method : {'linear', 'nearest', 'cubic'}, optional (default cubic)
        Just the ``method`` in scipy.interpolate.griddata.
        Method of interpolation. One of

            ``nearest``
            return the value at the data point closest to
            the point of interpolation. See `NearestNDInterpolator` for
            more details.

            ``linear``
            tessellate the input point set to N-D
            simplices, and interpolate linearly on each simplex. See
            `LinearNDInterpolator` for more details.

            ``cubic`` (1-D)
            return the value determined from a cubic
            spline.

            ``cubic`` (2-D)
            return the value determined from a
            piecewise cubic, continuously differentiable (C1), and
            approximately curvature-minimizing polynomial surface. See
            `CloughTocher2DInterpolator` for more details.

        extrapolate:
            Enable extrapolation (Logic)

    Return:
        The interpolated values in the shape of target
        longtitude & latitude

    Requirements:
        numpy
        scipy

    Code by Chen Huizhong, 2025-06-15.
    Assisted by AI (Deepseek & ChatGPT)
    """

    # Shape check
    assert lon_orig.shape == lat_orig.shape == values_orig.shape, (
        "inconsistent original data input shape"
    )
    assert lon_target.shape == lat_target.shape, "Target mesh shape is inconsistent"

    # Mask NaNs
    mask = ~np.isnan(values_orig)
    if not np.any(mask):
        return np.full_like(lon_target, np.nan)

    points = np.column_stack((lon_orig[mask], lat_orig[mask]))
    values = values_orig[mask]
    target_points = np.column_stack((lon_target.ravel(), lat_target.ravel()))

    # Interpolation
    result = griddata(points, values, target_points, method=method)

    # If extrapolation not allowed, mask out-of-bounds manually
    if not extrapolate:
        lon_min, lon_max = np.min(points[:, 0]), np.max(points[:, 0])
        lat_min, lat_max = np.min(points[:, 1]), np.max(points[:, 1])
        out_of_bounds = (
            (target_points[:, 0] < lon_min)
            | (target_points[:, 0] > lon_max)
            | (target_points[:, 1] < lat_min)
            | (target_points[:, 1] > lat_max)
        )
        result[out_of_bounds] = np.nan

    return result.reshape(lon_target.shape)
