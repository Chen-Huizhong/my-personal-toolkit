function State = RemoveWhiteFrame(filename)
    %REMOVEWHITEFRAME Remove the white frame of a figure.
    %
    %   State = RemoveWhiteFrame(filename)
    %
    % Input:
    %   filename: the name of the figure file, e.g., 'figure.png'
    % Output:
    %   State: 0 if the operation is successful, 1 if there is an error.
    % Usage:
    %   State = RemoveWhiteFrame('figure.png')
    %
    % This function removes the white frame around a figure image by detecting
    % the white pixels at the edges and cropping them out. It reads the image,
    % identifies the rows and columns that contain only white pixels, and
    % removes those rows and columns from the image. The modified image is then
    % saved back to the same file.
    % Note: This function assumes that the white frame is pure white (RGB value [255, 255, 255]).
    % It may not work correctly if the white frame is not pure white or if the
    % image has anti-aliasing effects that introduce off-white pixels.
    % Example:
    %   State = RemoveWhiteFrame('my_figure.png')
    %   This will remove the white frame from 'my_figure.png' and save the
    % modified image back to the same file.
    %
    % Code by Chen Huizhong, 2024-10-01.
    % Modified by Chen Huizhong, 2025-06-10: Adding comments and improving documentation.

    State = 1;
    im = imread(filename);
    white = uint8(256);

    imrow = size(im, 1);
    imcol = size(im, 2);

    rowidx = [];
    colidx = [];

    for ii = 1:imrow - 1

        if im(ii, :, :) == ones(size(im(ii, :, :)), 'uint8') * white & ...
                im(ii + 1, :, :) == ones(size(im(ii + 1, :, :)), 'uint8') * white
            rowidx = [rowidx; ii];
        else
            break;
        end

    end

    for ii = imrow:-1:2

        if im(ii, :, :) == ones(size(im(ii, :, :)), 'uint8') * white & ...
                im(ii - 1, :, :) == ones(size(im(ii - 1, :, :)), 'uint8') * white
            rowidx = [rowidx; ii];
        else
            break;
        end

    end

    for jj = 1:imcol - 1

        if im(:, jj, :) == ones(size(im(:, jj, :)), 'uint8') * white & ...
                im(:, jj + 1, :) == ones(size(im(:, jj + 1, :)), 'uint8') * white
            colidx = [colidx; jj];
        else
            break;
        end

    end

    for jj = imcol:-1:2

        if im(:, jj, :) == ones(size(im(:, jj, :)), 'uint8') * white & ...
                im(:, jj - 1, :) == ones(size(im(:, jj - 1, :)), 'uint8') * white
            colidx = [colidx; jj];
        else
            break;
        end

    end

    im(rowidx, :, :) = [];
    im(:, colidx, :) = [];

    imwrite(im, filename);
    State = 0;

end
