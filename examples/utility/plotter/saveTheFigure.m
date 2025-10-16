function saveTheFigure(tifFigureResolution, pressureDistributionMatLabFigureSavePath, pressureDistributionTifFigureSavePath)
    %% A convenient function to save the figure

    %% Input
    % tifFigureResolution: resolution of the tif figure
    % matLabFigureSavePath: path to save the figure in MATLAB format
    % tifFigureSavePath: path to save the figure in tif format

    if ~isempty(pressureDistributionTifFigureSavePath)
        f = gcf;
        exportgraphics(f, pressureDistributionTifFigureSavePath, 'resolution', 600);
    end
end