%% This script is used to generate matrix meshes.

%% Set parameters
h = 20;                     % groundwater head above the tunnel centerline
z = 20;                     % tunnel depth
ME = 100;                   % model extent
r = 3;                      % tunnel radius
aperture = 5e-5;            % fracture aperture
matrixToFracturePermRatio = 10^-3;  % kf/km
rockPerm = matrixToFracturePermRatio*(aperture^2/12);  % permeability of the rock matrix
rockPoro = 0.3;                                        % porosity of the rock matrix

%% Set the size of the computational domain
xLimits = [0, ME-2*r, ME+2*r, 2*ME];  % size in the x direction
xResolutions = [1, 0.05, 1];          % mesh resolution in the x direction
yLimits = [0, ME-2*r, ME+2*r, z+ME];  % size in the y direction
yResolutions = [1, 0.05, 1];          % mesh resolution in the y direction
zLimits = [0, 1];                     % size in the z direction
zResolutions = 1;                     % mesh resolution in the z direction
tunnelCenter = [ME, ME, 0.5];         % center of the tunnel

%% Generate a 3D structured Cartesain grid for the matrix domain
G = generateUnlinedTunnelStructuredGrid3D(xLimits, xResolutions, yLimits, yResolutions, zLimits, zResolutions, tunnelCenter, r);
G.h = h;
G.z = z;
G.ME = ME;
G.r = r;
G.rock = makeRock(G, rockPerm, rockPoro);

%% Save the mesh
matrixMeshSavePath = 'examples\workspaceData\matrixMesh.mat';  % path to save the matrix mesh
if ~isempty(matrixMeshSavePath)
    save(matrixMeshSavePath, 'G');
end