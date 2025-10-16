function plotGeometry(width, height, tunnelCenter, tunnelRadius, fracPlanes, pdfFigureSavePath)
    %% Plot the geometry

    %% Input
    % width: width of the rectangular domain
    % height: height of the rectangular domain
    % tunnelCenter: coordinate of the tunnel center
    % tunnelRadius: radius of the tunnel
    % fracPlanes: fracture planes
    % tifFigureResolution: resolution of the tif figure
    % matLabFigureSavePath: path to save the figure in MATLAB format
    % tifFigureSavePath: path to save the figure in tif format

    figure;

    %% Plot the rectangular domain
    rectangle('Position', [0, 0, width, height]);

    %% Plot the tunnel
    if ~isempty(tunnelCenter)
        hold on;
        rectangle('Position', [tunnelCenter(1)-tunnelRadius, tunnelCenter(2)-tunnelRadius, 2*tunnelRadius, 2*tunnelRadius], 'Curvature', [1, 1]);
    end

    %% Plot the fracture planes
    if ~isempty(fracPlanes)
        for i = 1:length(fracPlanes)
            hold on;
            fracPlane = fracPlanes(i).points;
            x = fracPlane(1:2, 1);
            y = fracPlane(1:2, 2);

            plot(x, y, 'black', 'linewidth', 1.5);
        end
    end

    %% Format the figure
    box off;
    axis equal tight;
    xticks([]);
    yticks([]);

    %% Save the figure
    saveTheFigure(pdfFigureSavePath);
end