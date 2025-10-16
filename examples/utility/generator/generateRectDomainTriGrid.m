function [G] = generateRectDomainTriGrid(height, width, initialEdgeLength)
    %% Generate a triangular grid on a rectangular domain

    %% Input
    % height: height of the domain
    % width: width of the domain
    % initialEdgeLength: initial edge length of the triangle grid

    %% Output
    % G: grid

    %% Load relevant modules
    pth = fullfile(ROOTDIR, 'utils', '3rdparty', 'distmesh');
    mkdir(pth);
    unzip('http://persson.berkeley.edu/distmesh/distmesh.zip', pth);
    mrstPath('reregister','distmesh',pth);

    mrstModule add distmesh;
    mrstModule add upr;

    %% Distance function
    fd = @(p) drectangle(p, 0, width, 0, height);

    %% Generate the 2-D grid using distmesh2d
    [p, t] = distmesh2d(fd, @huniform, initialEdgeLength, [0, 0; width, height], [0, 0; 0, height; width, 0; width, height], false);

    %% Create a triangle grid in the form of the MRST grid structure
    G = triangleGrid(p, t);
    G = computeGeometry(G);
end