function [G] = generateUnlinedTunnelTriGrid(h, ME, r, initialEdgeLength, linearize)
    %% Generate a triangular grid for an unlined tunnel with a circular cross-section
    
    %% Input
    % h: groundwater head above the tunnel centerline
    % ME: model extent
    % r: tunnel radius
    % initialEdgeLength: initial edge length of the triangle grid (0.3)
    % linearize: interpolate the scaled edge length function between vertex values

    %% Output
    % G: a triangular grid

    %% COMSOL element size parameters
    % Maximum element size: 5
    % Minimum element size: 0.01
    % Maximum element growth rate: 1.1
    % Curvature factor: 0.2
    % Resolution of narrow regions: 1

    %% Load relevant modules
    pth = fullfile(ROOTDIR, 'utils', '3rdparty', 'distmesh');
    mkdir(pth);
    unzip('http://persson.berkeley.edu/distmesh/distmesh.zip', pth);
    mrstPath('reregister','distmesh',pth);

    mrstModule add distmesh;
    mrstModule add upr;

    %% Distance function
    fd = @(p) ddiff(drectangle(p, 0, 2*ME, 0, ME+h), dcircle(p, ME, ME, r));  

    %% Scaled edge length function
    fh = @(p) 1+0.1*dcircle(p, ME, ME, r);

    %% Generate the 2-D grid using distmesh2d
    [p, t] = distmesh2d(fd, fh, initialEdgeLength, [0, 0; 2*ME, ME+h], [0, 0; 0, ME+h; 2*ME, 0; 2*ME, ME+h], linearize);

    %% Create a triangle grid in the form of the MRST grid structure
    G = triangleGrid(p, t);
    G = computeGeometry(G);
end