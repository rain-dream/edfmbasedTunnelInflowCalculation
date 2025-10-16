%% This script is used to plot the geometry of the computational domain.

%% Set parameters
h = 20;                      % groundwater head above the tunnel centerline
z = 20;                      % tunnel depth
ME = 100;                    % model extent
tunnelRadius = 3;            % tunnel radius
tunnelCenter = [ME ME];      % tunnel center

%% Set relevant file paths
fracPlanesSavePath = 'examples\workspaceData\fracPlanes.mat';
figureSavePath = 'examples\script\computationalDomainGeneration\fig\computationalDomain.tif';
figureResolution = 600;

%% Load relevant data
load(fracPlanesSavePath, "fracPlanes");

%% Plot the geometry of the computational domain
plotDomainGeometry(2*ME, ME+z, tunnelCenter, tunnelRadius, fracPlanes, figureResolution, figureSavePath);