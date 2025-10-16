function plotMatrixPressureRelativeErrorDistribution(G, matrixPressureRelativeError, isWithFractures, colorBarLim, xTicks, yTicks, tifFigureResolution, matlabFigureSavePath, tifFigureSavePath)
    %% Plot the matrix pressure relative error distribution

    %% Input
    % G: grid
    % matrixPressureRelativeError: matrix pressure relative error
    % isWithFractures: boolean indicating if the domain has fractures
    % colorBarLim: color bar limit
    % xTicks: x-axis ticks
    % yTicks: y-axis ticks
    % tifFigureResolution: resolution of the tif figure
    % matlabFigureSavePath: path to save the figure in MATLAB format
    % tifFigureSavePath: path to save the figure in tif format

    figure;

    %% Plot the matrix pressure relative error distribution
    if isWithFractures
        plotCellData(G, matrixPressureRelativeError', 1:G.Matrix.cells.num, ...
            'FaceAlpha', 0.5, 'EdgeAlpha', 0.0);
    else
        plotCellData(G, matrixPressureRelativeError', 1:G.cells.num, ...
            'FaceAlpha', 0.5, 'EdgeAlpha', 0.0);
    end

    %% Format the figure
    formatFigure(colorBarLim, '', xTicks, yTicks);

    %% Save the figure
    saveTheFigure(tifFigureResolution, matlabFigureSavePath, tifFigureSavePath);
end