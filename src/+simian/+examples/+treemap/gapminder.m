function yearData = gapminder(year)
    persistent data;

    if isempty(data)
        folder  = fileparts(mfilename("fullpath"));
        data    = readtable(fullfile(folder, "gapminder.csv"));

        % Add parents and ids.
        data.parent = "world/" + data.continent;
        data.id     = data.parent + "/" + data.country;

        % Aggregate continent data.
        continentData           = aggregatePopAndLifeExp(data, ["year", "continent"]);
        continentData.country   = string(continentData.continent);
        continentData.parent    = repmat("world", height(continentData), 1);
        continentData.id        = continentData.parent + "/" + continentData.continent;

        % Aggregate world data.
        worldData           = aggregatePopAndLifeExp(continentData, "year");
        worldData.country   = repmat("world", height(worldData), 1);
        worldData.parent    = repmat("", height(worldData), 1);
        worldData.id        = worldData.country;

        % Remove unneeded data.
        data = removevars(data, ["gdpPercap", "continent", "iso_alpha", "iso_num", "centroid_lon", "centroid_lat"]);

        continentData.continent = [];

        % Concatenate tables.
        data = [data; continentData; worldData];
    end

    if strcmp(year, ":")
        yearData = data;
    else
        rowIdx      = data.year == year;
        yearData    = data(rowIdx, :);
    end
end

%% aggregatePopAndLifeExp
function aggregatedData = aggregatePopAndLifeExp(data, grouping)
    % Total population of a group is the sum of its parts.
    pop = groupsummary(data, grouping, @sum, "pop");

    % Total life expectancy of a group is the mean weighted with the population of its parts.
    lifeExp = groupsummary(data, grouping, @weightedMean, {"lifeExp", "pop"});

    % Fix up the tables.
    pop.Properties.VariableNames{end}       = 'pop';
    lifeExp.Properties.VariableNames{end}   = 'lifeExp';

    pop.GroupCount      = [];
    lifeExp.GroupCount  = [];

    % Join the tables.
    aggregatedData = innerjoin(pop, lifeExp, "Keys", grouping);
end


%% weightedMean
function [m, s] = weightedMean(x, w)
    s = sum(x);
    m = sum(x .* w) / sum(w);
end
