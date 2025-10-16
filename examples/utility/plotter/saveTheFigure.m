function saveTheFigure(figureResolution, figureSavePath)
    %% A convenient function to save the figure

    %% Input
    % figureResolution: resolution of the figure
    % figureSavePath: file path to save the figure

    if ~isempty(figureSavePath)
        view(2);
        axis on;
        f = gcf;
        exportgraphics(f, figureSavePath, 'resolution', figureResolution);
    end
end