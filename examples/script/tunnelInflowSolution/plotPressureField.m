%% This script is used to plot the pressure field.

%% Set parameters
h = 20;                      % groundwater head above the tunnel centerline
z = 20;                      % tunnel depth
ME = 100;                    % model extent
tunnelRadius = 3;            % tunnel radius
tunnelCenter = [ME ME];      % tunnel center

%% Set relevant file paths
fractureMeshSavePath = 'examples\workspaceData\fractureMesh.mat';
solutionSavePath = 'examples\workspaceData\solution.mat';

%% Load relevant data
load(fractureMeshSavePath, "matrixFractureG");
load(solutionSavePath, "states");

%% Set plotting parameters
colorBarLim = [0 12e5];
xTicks = 0:20:200;
yTicks = 0:20:120;
isWithFractures = true;
figureResolution = 600;
figureSavePath = 'examples\script\tunnelInflowSolution\fig\pressureField.tif';
plotPressureDistributionEDFM(matrixFractureG, states, colorBarLim, xTicks, yTicks, isWithFractures, ...
figureResolution, figureSavePath);