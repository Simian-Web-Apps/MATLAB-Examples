function payload = guiInit(~)
    % guiInit Initialize the form.
    %     payload = guiInit(metaData) Initializes the form and returns it in the payload.
    %
    % Inputs:
    % - metaData    Form meta data.
    %
    % Returns:
    % - payload     Payload containing the form definition.

    % Copyright 2021-2024 MonkeyProof Solutions BV.

    % CC4M file wide exemptions.
    %@ok<*LILEN-LAYOUT-5>  BuildTables usually violate line length constraints when tooltips are involved.

    import simian.gui.*;

    % Prepare build table columns list and often used options.
    COLUMN_KEYS                 = ["key", "class", "level", "options", "defaultValue", "label", "tooltip"];
    collapsePanel.collapsible   = true;
    inline.customClass          = "form-check-inline";
    labelLeft.labelPosition     = "left-left";
    showLabel.hideLabel         = false;

    % Create a form.
    form = Form("form");

    % Create tabs for Inputs and Used Settings.
    tabs            = component.Tabs("tabs", form);
    [tabA, tabB]    = tabs.setContent(["Inputs", "Used settings"], "Keys", ["Inputs", "Settings"]);

    % Create a Columns object and fill it with two empty columns.
    col                 = component.Columns("inputColumns", tabA);
    [column1, column2]  = col.setContent({}, [6, 6]);

    %% Options
    windDisable                     = simian.gui.componentProperties.createDisableLogic("simple", {"enableDrag", false});
    windDisable.actions{end + 1}    = struct("type", "value", "value", "value = false");

    windOptions         = inline;
    windOptions.logic   = {windDisable};

    buildTable = cell2table({
        % key           class           level   options         default     label           tooltip
        "options",      "Container",    1,      showLabel,      missing,    "Options:",     missing
        "enableDrag",   "Checkbox",     2,      inline,         false,      "Enable Drag",  "Enable the simulation of the effect of drag on the thrown ball."
        "enableWind",   "Checkbox",     2,      windOptions,    false,      "Enable Wind",  "Enable the simulation of the effect of wind on the thrown ball. Requires drag to be enabled."
        },  "VariableNames", COLUMN_KEYS);
    utils.addComponentsFromTable(column1, buildTable);

    % Allow values between 0 and 20 m/s.
    speedValidate.min       = 0;
    speedValidate.max       = 20;
    speedValidate.required  = true;
    speedOptions            = labelLeft;
    speedOptions.validate   = speedValidate;

    %% Throw
    buildTable = cell2table({
        % key               class       level   options         default     label                       tooltip
        "throwPanel",       "Panel",    1,      collapsePanel,  missing,    "Throw settings",           missing
        "speedHorizontal",  "Number",   2,      speedOptions,   10,         "Horizontal speed [m/s]:",  "Horizontal speed with which the ball is thrown."
        "speedVertical",    "Number",   2,      speedOptions,   5,          "Vertical speed [m/s]:",    "Vertical speed with which the ball is thrown."
        }, "VariableNames", COLUMN_KEYS);
    utils.addComponentsFromTable(column1, buildTable);

    %% Ball properties
    % Hide ball panel when drag is not enabled.
    dragEnabled.when            = "enableDrag";
    dragEnabled.eq              = false;
    ballPanelOpts               = collapsePanel;
    ballPanelOpts.conditional   = dragEnabled;

    % Allow values larger than 0.
    ballMassValidate.min        = 0.000001;
    ballMassValidate.required   = true;
    ballMassOpts                = labelLeft;
    ballMassOpts.validate       = ballMassValidate;

    % Allow valueslarger than 0.
    ballRadiusValidate.min      = 0;
    ballRadiusValidate.required = true;
    ballRadiusOpts              = labelLeft;
    ballRadiusOpts.validate     = ballRadiusValidate;

    % Allow values between 0 and 10.
    dragCoeffValidate.min       = 0;
    dragCoeffValidate.max       = 10;
    dragCoeffValidate.required  = true;
    dragCoeffOpts               = labelLeft;
    dragCoeffOpts.validate      = dragCoeffValidate;

    buildTable = cell2table({
        % key               class       level   options         default     label                       tooltip
        "ballPanel",        "Panel",    1,      ballPanelOpts,  missing,    "Ball settings",            missing
        "ballMass",         "Number",   2,      ballMassOpts,   0.05,       "Mass [kg]:",               "Mass of the ball."
        "ballRadius",       "Number",   2,      ballRadiusOpts, 0.1,        "Radius [m]:",              "Radius of the ball."
        "dragCoefficient",  "Number",   2,      dragCoeffOpts,  0.4,        "Drag coefficient [-]:",    "Drag coefficient of the ball."
        }, "VariableNames", COLUMN_KEYS);

    utils.addComponentsFromTable(column1, buildTable);

    %% Constants
    % Create a Number textfield for the gravity.
    gravity                 = component.Number("gravity");
    gravity.label           = "Gravity [m/s<sup>2</sup>]:";
    gravity.labelPosition   = "left-left";
    gravity.tooltip         = "Gravitational accelleration acting on the ball.";
    gravity.defaultValue    = 9.81;

    % Allow values between 0 and 20 m/s^2.
    gravityValidate.min         = 0;
    gravityValidate.max         = 20;
    gravityValidate.required    = true;
    gravityOpts                 = labelLeft;
    gravityOpts.validate        = gravityValidate;

    % Allow values between 0 and 10 kg/m^3.
    airDensityValidate.min      = 0;
    airDensityValidate.max      = 10;
    airDensityValidate.required = true;
    airDensOpts                 = labelLeft;
    airDensOpts.validate        = airDensityValidate;
    airDensOpts.conditional     = dragEnabled;

    buildTable = cell2table({
        % key               class       level   options         default     label                               tooltip
        "constantsPanel",  "Panel",     1,      collapsePanel,  missing,    "Constants",                        missing
        "gravity",         "Number",    2,      gravityOpts,    9.81,       "Gravity [m/s<sup>2</sup>]:",       "Gravitational accelleration acting on the ball."
        "airDensity",      "Number",    2,      airDensOpts,    1.29,       "Air density [kg/m<sup>3</sup>]:",  "Density of the air through which the ball moves."
        }, "VariableNames", COLUMN_KEYS);
    utils.addComponentsFromTable(column1, buildTable);

    %% Wind
    % Hide wind panel when wind is not enabled.
    windCondition.when              = "enableWind";
    windCondition.eq                = false;
    windPanelOptions                = collapsePanel;
    windPanelOptions.conditional    = windCondition;

    % Allow values between 0 and 20 m/s.
    windSpeedValidate.min       = -10;
    windSpeedValidate.max       = 10;
    windSpeedValidate.required  = true;
    windSpeedOptions            = labelLeft;
    windSpeedOptions.validate   = windSpeedValidate;

    buildTable = cell2table({
        % key           class       level   options             default     label                   tooltip
        "windPanel",   "Panel",     1,      windPanelOptions,   missing,    "Wind settings",        missing
        "windSpeed",   "Number",    2,      windSpeedOptions,   -1,         "Wind speed [m/s]:",    "Wind speed. Positive values correspond with tailwind. Negative values correspond with headwind."
        }, "VariableNames", COLUMN_KEYS);
    utils.addComponentsFromTable(column1, buildTable);

    %% Action buttons
    throwOptions                    = inline;
    throwOptions.disableOnInvalid   = true;

    errorOptions        = inline;
    errorOptions.theme  = "danger";

    buildTable = cell2table({
        % key           class           level   options         label               tooltip
        "ButtonPanel",  "Container",    1,      showLabel,      "Actions:",         missing
        "throwButton",  "Button",       2,      throwOptions,   "Throw",            "Click to simulate a throw with the chosen settings."
        "clearButton",  "Button",       2,      inline,         "Clear results",    "Click to remove all of the current results."
        "errorButton",  "Button",       2,      errorOptions,   "Cause error",      "Click to cause an error and see the error handling in action."
        }, ...
        "VariableNames", setxor(COLUMN_KEYS, "defaultValue", "stable"));

    componentStruct = utils.addComponentsFromTable(column2, buildTable);

    % Add the events to the buttons.
    componentStruct.throwButton.setEvent("Throwing");
    componentStruct.clearButton.setEvent("ClearHistory");
    componentStruct.errorButton.setEvent("CauseError");

    %% Plot
    % Create a plot window to plot the ball trajectories in.
    throwPlot                      = component.Plotly("plot", column2);
    throwPlot.defaultValue.data    = {};
    throwPlot.defaultValue.config  = struct("displaylogo", false);
    throwPlot.defaultValue.layout  = struct(...
        "title",    struct("text",  "Balls thrown"), ...
        "xaxis",    struct("title", "Distance [m]"), ...
        "yaxis",    struct("title", "Height [m]"), ...
        "margin",   struct("t", 40, "b", 60, "l", 50));

    %% Used settings table.
    % Create a table to store the throw settings in.
    tableOut        = component.DataTables("summary", tabB);
    tableOut.label  = "Used settings per throw";
    tableOut.setOutputAs("table");
    tableOut.setFeatures("searching", false, "ordering", false, "paging", false)
    tableOut.setColumns( ...
        ["Id", "Attempt", "Horizontal speed", "Vertical speed", "Wind speed", "Ball mass", "Radius", "Drag Coeff.", ...
        "Gravity", "Air density"], ...
        ["id", "nr", "u0", "v0", "w", "m", "r", "Cd", "g", "rho"], ...
        "visible", [false, true(1, 9)]);

    % Put the form in the outputs.
    payload.form = form;

    % Setup navbar.
    imageFile               = fullfile(fileparts(mfilename("fullpath")), "logo.png");
    payload.navbar.logo     = utils.encodeImage(imageFile);
    payload.navbar.title    = "Ball Thrower";
    payload.navbar.subtitle = "<small>MonkeyProof Demo</small>";

    % Flag changes to the settings in the UI.
    payload.showChanged = true;
end
