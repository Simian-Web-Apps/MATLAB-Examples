function [layout, data] = selectYear(year)
    % Get the data for the year.
    yearData = simian.examples.treemap.gapminder(year);

    % Find the world data to select the mean value.
    worldIdx = yearData.id == "world";
    
    % Set the layout an plot data according to https://plotly.com/javascript/reference/treemap/
    layout.coloraxis.colorbar.title.text    = "Life expectancy";
    layout.coloraxis.colorscale             = getPlotlyColorScale();
    layout.coloraxis.cmid                   = yearData.lifeExp(worldIdx);
    layout.legend.tracegroupgap             = 0;
    layout.margin.t                         = 50;
    layout.margin.l                         = 25;
    layout.margin.r                         = 25;
    layout.margin.b                         = 25;

    trace.branchvalues      = "total";
    trace.domain.x          = [0, 1];
    trace.domain.y          = [0, 1];
    trace.hovertemplate     = "Country: %{label}<br>Population: %{value}<br>Continent: %{parent}<br>Life expectancy: %{color}";
    trace.ids               = yearData.id;
    trace.labels            = yearData.country;
    trace.marker.coloraxis  = "coloraxis";
    trace.marker.colors     = yearData.lifeExp;
    trace.name              = "";
    trace.parents           = yearData.parent;
    trace.values            = yearData.pop;
    trace.type              = "treemap";

    data = {trace};
end

%% getPlotlyColorScale
function colorScale = getPlotlyColorScale()
    % Define a custom colormap for the treemap.
    cmap = [
        103, 0,   31
        178, 24,  43
        214, 96,  77
        244, 165, 130
        253, 219, 199
        247, 247, 247
        209, 229, 240
        146, 197, 222
        67,  147, 195
        33,  102, 172
        5,   48,  97
        ];

    % Construct the color data in the plotly format.
    levels      = linspace(0, 1, length(cmap));
    colorScale  = {};

    for level = 0 : 0.1 : 1
        color               = uint8(interp1(levels, cmap, level));
        colorScale{end + 1} = {level, sprintf('rgb(%d, %d, %d)', color)}; %#ok<AGROW>
    end
end
