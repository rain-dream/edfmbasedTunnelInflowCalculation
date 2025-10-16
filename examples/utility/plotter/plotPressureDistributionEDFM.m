function plotPressureDistributionEDFM(G, states, colorBarLim, xTicks, yTicks, isWithFractures, figureResolution, figureSavePath)
    %% Plot the EDFM model's pressure distribution
    
    %% Input
    % G: grid
    % states: solution
    % colorBarLim: color bar limit
    % xTicks: x-axis ticks
    % yTicks: y-axis ticks
    % isWithFractures: boolean indicating if the domain has fractures
    % figureResolution: resolution of the figure
    % figureSavePath: file path to save the figure

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
    saveTheFigure(figureResolution, figureSavePath);
end