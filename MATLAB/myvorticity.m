function vort = myvorticity(lon, lat, var_x, var_y)
    %MYVORTICITY Calculate the vorticity of a vector field.
    %   myvorticity(lon,lat,var_x,var_y) calculates the vorticity of a vector
    %   field defined by the x and y components (var_x and var_y) at the
    %   specified longitude (lon) and latitude (lat) coordinates.
    %
    %   vort = myvorticity(lon,lat,var_x,var_y)
    %
    % Inputs:
    %   lon: longitude(row or column), corresponding to the x direction
    %   lat: latitude(row or column), corresponding to the y direction
    %   var_x: variable field in x direction (2D or 3D matrix)
    %   var_y: variable field in y direction (2D or 3D matrix)
    % Outputs:
    %   vort: the vorticity of var
    % Usage:
    %   lon = 0:1:10; % Example longitude
    %   lat = 0:1:10; % Example latitude
    %   var_x = rand(length(lon), length(lat)); % Example x component
    %   var_y = rand(length(lon), length(lat)); % Example y component
    %   vort = myvorticity(lon, lat, var_x, var_y); % Calculate vorticity
    %
    % The boundary of vort is NaN.
    % This function need the gsw_distance to calculate the distance.
    %
    % Code by Chen Huizhong, 2025-06-10.
    % Modified by Chen Huizhong, 2025-06-10: Adding comments and improving documentation.

    if nargin ~= 4
        error('Invalid input! Four inputs are required: lon, lat, var_x, var_y');
    end

    if ~isrow(lon) && ~iscolumn(lon)
        error('input lon must be 1-dimension');
    end

    if ~isrow(lat) && ~iscolumn(lat)
        error('input var must be 1-dimension');
    end

    if size(var_x) ~= size(var_y)
        error('var_x and var_y should have the same dimensions');
    end

    if ~ismatrix(var_x) && ndims(var_x) ~= 3
        error('input var_x must have 2 or 3 dimensions');
    end

    if ~ismatrix(var_y) && ndims(var_y) ~= 3
        error('input var_x must have 2 or 3 dimensions');
    end

    if iscolumn(lon)
        lon = lon';
    end

    if iscolumn(lat)
        lat = lat';
    end

    xSize = length(lon);
    ySize = length(lat);
    size1 = size(var_x, 1);
    size2 = size(var_x, 2);

    if xSize ~= size1 || ySize ~= size2
        error('the dimension of var_x&var_y should be [length(lon), length(lat), :]');
    end

    disp('Start calculating vorticity...');
    tic;
    dvdx = nan(size(var_x));
    dudy = nan(size(var_x));

    for ix = 2:xSize - 1

        for iy = 2:ySize - 1
            du = var_x(ix, iy + 1, :) - var_x(ix, iy - 1, :);
            dy = gsw_distance(lon([ix, ix]), lat([iy + 1, iy - 1]));
            dudy(ix, iy, :) = du / dy;
            dv = var_y(ix + 1, iy, :) - var_y(ix - 1, iy, :);
            dx = gsw_distance(lon([ix + 1, ix - 1]), lat([iy, iy]));
            dvdx(ix, iy, :) = dv / dx;
        end

    end

    vort = dvdx - dudy;
    toc;
    disp('Done calculating vorticity...');
end
