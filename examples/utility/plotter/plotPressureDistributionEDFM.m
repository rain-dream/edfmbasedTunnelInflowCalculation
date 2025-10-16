function plotPressureDistributionEDFM(G, states, colorBarLim, xTicks, yTicks, isWithFractures, tifFigureResolution, pressureDistributionMatLabFigureSavePath, pressureDistributionTifFigureSavePath)
    %% Plot the EDFM model's pressure distribution
    
    %% Input
    % G: grid
    % states: solution
    % colorBarLim: color bar limit
    % xTicks: x-axis ticks
    % yTicks: y-axis ticks
    % isWithFractures: boolean indicating if the domain has fractures
    % tifFigureResolution: resolution of the tif figure
    % matLabFigureSavePath: path to save the figure in MATLAB format
    % tifFigureSavePath: path to save the figure in tif format

    figure('Position', [100, 100, 600, 500]);

    %% Plot the pressure distribution
    if isWithFractures
        plotCellData(G, states{1}.pressure, 1:G.Matrix.cells.num, ...
                    'FaceAlpha', 1, 'EdgeAlpha', 0.0);
        plotCellData(G, states{1}.pressure, G.Matrix.cells.num+1:G.cells.num);
    else
        plotCellData(G, states{1}.pressure, 1:G.cells.num, ...
                    'FaceAlpha', 1, 'EdgeAlpha', 0.0);
    end

    view(0, 90);
    %% Format the figure
    formatFigure(colorBarLim, 'Pa', xTicks, yTicks);

    %% Save the figure
    saveTheFigure(tifFigureResolution, pressureDistributionMatLabFigureSavePath, pressureDistributionTifFigureSavePath);
end