function days = Date2Days(month, day, year)
    %DATE2DAYS(month, day, year) converts a specific date
    % to the corresponding day in the year.
    %
    %     days = Date2Days(month, day, year)
    %
    % Input:
    %   month: month of the specific date
    %   day: day of the specific date
    %   year: year of the specific date
    % Output:
    %   days: the corresponding day in the year
    % Usage:
    %   days = Date2Days(1, 10, 2024)
    %   return days = 10
    %
    % Code by Chen Huizhong, 2025-06-10.

    if nargin ~= 3
        error('Invalid input!');
    end

    if month > 12 || month < 1
        error('Invalid month value!');
    end

    daysOfMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if day < 1 || day > daysOfMonth(month)
        error('Invalid day value!');
    end

    if (mod(year, 4) == 0 && mod(year, 100) ~= 0) || mod(year, 400) == 0
        daysOfMonth(2) = 29;
    end

    days = sum(daysOfMonth(1:month - 1)) + day;
end
