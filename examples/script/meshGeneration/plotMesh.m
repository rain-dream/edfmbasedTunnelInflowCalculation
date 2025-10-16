%% This script is used to plot meshes.

mrstModule add hfm;

%% Set parameters
h = 20;                      % groundwater head above the tunnel centerline
z = 20;                      % tunnel depth
ME = 100;                    % model extent
tunnelRadius = 3;            % tunnel radius
tunnelCenter = [ME ME];      % tunnel center

%% Set relevant file paths
matrixMeshSavePath = 'examples\workspaceData\matrixMesh.mat';  
fracPlanesSavePath = 'examples\workspaceData\processedFracPlanes.mat';
meshFigureSavePath = 'examples\script\meshGeneration\fig\mesh.tif';
figureResolution = 600;

%% Load relevant data
load(matrixMeshSavePath, "G");
load(fracPlanesSavePath, "fracLines");

%% Plot the mesh
plotfracongrid(G, fracLines, 'label', false, 'facefacealpha', 1, 'facefacecolor', 'black');

saveTheFigure(figureResolution, meshFigureSavePath);