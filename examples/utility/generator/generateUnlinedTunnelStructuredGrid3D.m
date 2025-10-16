function [G] = generateUnlinedTunnelStructuredGrid3D(xLimits, xResolutions, yLimits, yResolutions, zLimits, zResolutions, tunnelCenter, tunnelRadius)
    %% Generate a 3D structured grid with a tunnel

    %% Input
    % xLimits: x coordinate of points to split x axis
    % xResolutions: resolution of each subparts of x axis
    % yLimits: y coordinate of points to split y axis
    % yResolutions: resolution of each subparts of y axis
    % zLimits: z coordinate of points to split z axis
    % zResolutions: resolution of each subparts of z axis

    %% Output
    % G: 3D structured grid with a tunnel

    %% Generate a rectilinear grid
    G = generateRectilinearGrid(xLimits, xResolutions, yLimits, yResolutions, zLimits, zResolutions);

    %% Remove cells in the tunnel domain
    c = G.cells.centroids;
    d = sqrt((c(:, 1)-tunnelCenter(1)).^2 + (c(:, 2)-tunnelCenter(2)).^2 );
    G = removeCells(G, ~(d>tunnelRadius));
end


function [G] = generateRectilinearGrid(xLimits, xResolutions, yLimits, yResolutions, zLimits, zResolutions)
    mrstModule add hfm

    %% Generate a rectilinear grid

    %% Input
    % xLimits: x coordinate of points to split x axis
    % xResolutions: resolution of each subparts of x axis
    % yLimits: y coordinate of points to split y axis
    % yResolutions: resolution of each subparts of y axis
    % zLimits: z coordinate of points to split z axis
    % zResolutions: resolution of each subparts of z axis

    %% Output
    % G: a rectilinear grid

    x = [];
    y = [];
    z = [];
    
    %% Generate x, y, z coordinates of grid vertices
    for i = 1:length(xResolutions)
        x = [x, xLimits(i):xResolutions(i):xLimits(i+1)];
    end

    for i = 1:length(yResolutions)
        y = [y, yLimits(i):yResolutions(i):yLimits(i+1)];
    end

    for i = 1:length(zResolutions)
        z = [z, zLimits(i):zResolutions(i):zLimits(i+1)];
    end

    x = unique(x);
    y = unique(y);
    z = unique(z);

    %% Generate rectilinear grid
    G = tensorGrid(x, y, z);
    G = computeGeometry(G);
end