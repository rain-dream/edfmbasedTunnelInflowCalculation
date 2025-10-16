%% This script is used to compute tunnel water inflow.

%% Set relevant file paths
processedFracPlanesSavePath = 'examples\workspaceData\processedFracPlanes.mat';
matrixMeshSavePath = 'examples\workspaceData\matrixMesh.mat';
fractureMeshSavePath = 'examples\workspaceData\fractureMesh.mat';
solutionSavePath = 'examples\workspaceData\solution.mat';

%% Load relevant data
load(processedFracPlanesSavePath, "fracLines");
load(matrixMeshSavePath, "G");
load(fractureMeshSavePath, "matrixFractureG");
load(solutionSavePath, "states");

%% Compute tunnel inflow
h = 20;
ME = 100;
aperture = 5e-5;
[fracIds] = findIntersectTunnelFracId(fracLines, h, ME);
fracTunnelIntersectX = zeros(1, length(fracIds));
for i = 1:length(fracIds)
    fracId = fracIds(i);
    fracFirstPoint = fracLines(fracId).points(1, 1:2);
    fracSecondPoint = fracLines(fracId).points(2, 1:2);

    distOfFirstFracPointToTunnelCenter = sqrt((fracFirstPoint(1)-ME)^2+(fracFirstPoint(2)-ME)^2);
    distOfSecondFracPointToTunnelCenter = sqrt((fracSecondPoint(1)-ME)^2+(fracSecondPoint(2)-ME)^2);
    if distOfFirstFracPointToTunnelCenter < distOfSecondFracPointToTunnelCenter
        nearPoint = fracFirstPoint;
    else
        nearPoint = fracSecondPoint;
    end

    fracTunnelIntersectX(i) = nearPoint(1);
end

format long;

tunnelFracInterFaceCentroids = [97.7 98.075;
                                102.3 101.925;
                                101.925 97.7;
                                98.075 102.3];

q = calculateTunnelInflowStructuredGrid3DWithCrossingFracture(G, matrixFractureG, states, fracIds, fracTunnelIntersectX, ones(1,length(fracIds))*aperture, tunnelFracInterFaceCentroids);
disp(q);