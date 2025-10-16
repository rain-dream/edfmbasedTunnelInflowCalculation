function plotGridEDFM(G, fracPlanes, xTicks, yTicks, tifFigureResolution, matLabFigureSavePath, tifFigureSavePath)
    %% Plot the EDFM grid

    %% Input 
    % G: grid
    % fracPlanes: fracture planes
    % xTicks: x-axis ticks
    % yTicks: y-axis ticks
    % tifFigureResolution: resolution of the tif figure
    % matLabFigureSavePath: path to save the figure in MATLAB format
    % tifFigureSavePath: path to save the figure in tif format

    %% Load relevant modules
    mrstModule add hfm;

    figure;

    %% Plot the EDFM grid
    plotfracongrid(G, fracPlanes, 'label', false, 'facefacealpha', 1, 'facefacecolor', 'black', 'fracturelist', 1);

    %% Format the figure
    view(0, 90);
    box on;
    axis equal tight;
    xticks(xTicks);
    yticks(yTicks);
    set(gca, 'FontName', 'Times New Roman');
    ax = gca;
    ax.XAxis.FontSize = 14;
    ax.YAxis.FontSize = 14;
    ax.XLabel.String = 'x (m)';
    ax.YLabel.String = 'y (m)';
    ax.XLabel.FontSize = 18;
    ax.YLabel.FontSize = 18;

    %% Save the figure
    if ~isempty(matLabFigureSavePath)
        savefig(matLabFigureSavePath);
    end

    if ~isempty(tifFigureSavePath)
        f = gcf;
        exportgraphics(f, tifFigureSavePath, 'Resolution', tifFigureResolution);
    end
end