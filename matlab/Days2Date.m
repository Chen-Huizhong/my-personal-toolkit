function date = Days2Date(days, year)
    %DAYS2DATE(days, year) convert a specific day to the corresponding
    % date in the year.
    %
    %     date = Days2Date(days, year)
    %
    % Input:
    %   days: the specific day
    %   year: the corresponding year
    % Output:
    %   date: the corresponding date in the year
    % Usage:
    %   days = Days2Date(10, 2024)
    %   return days = 1   10
    %
    % Code by Chen Huizhong, 2025-06-10.

    if nargin ~= 2
        error('Invalid input!');
    end

    daysOfMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (mod(year, 4) == 0 && mod(year, 100) ~= 0) || mod(year, 400) == 0
        daysOfMonth(2) = 29;
    end

    month = find(((days - cumsum(daysOfMonth)) <= 0) == 1, 1);
    lag = sum(daysOfMonth(1:month)) - days;
    day = daysOfMonth(month) - lag;
    date = [month, day];
end
