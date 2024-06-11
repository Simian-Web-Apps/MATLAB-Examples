function payload = guiInit(~)
    import simian.gui.*;

    % Register component initializers.
    Form.componentInitializer(...
        treemap=@initTreemap, ...
        year=@initYear, ...
        treemapPreloaded=@initTreemapPreloaded, ...
        preloadedData=@initPreloadedData);

    % Create the form and load the json builder into it.
    form = Form(FromFile=fullfile(fileparts(mfilename("fullpath")), "form.json"));

    % Add the form to the payload and set the title on the navbar.
    payload = struct(...
        "form", form, ...
        "navbar", struct("title", "World population and life expectancy"));
end

%% initTreemap
function initTreemap(comp)
    % Initialize the treemap with data from the year 2007.
    [comp.defaultValue.layout, comp.defaultValue.data] = simian.examples.treemap.selectYear(2007);
end

%% initYear
function initYear(comp)
    % Make the slider emit events one second after each change. Only the last value is used.
    comp.addCustomProperty("triggerHappy", "YearSelected");
    comp.addCustomProperty("debounceTime", 1000);
end

%% initTreemapPreloaded
function initTreemapPreloaded(comp)
    % Set the calculateValue to call the JavaScript function that selects the data for the year.
    comp.setCalculateValue("console.log(data); value = fillTreemap(data.preloadedData, data.yearPreloaded);");
    [comp.defaultValue.layout, comp.defaultValue.data] = simian.examples.treemap.selectYear(2007);
end

%% initPreloadedData
function initPreloadedData(comp)
    % Load data for all years.
    data = simian.examples.treemap.gapminder(":");

    % Set the default value of the hidden component.
    comp.defaultValue = struct(...
        "countries", data.country, ...
        "parents", data.parent, ...
        "ids", data.id, ...
        "lifeExp", data.lifeExp, ...
        "pop", data.pop, ...
        "years", data.year);
end
