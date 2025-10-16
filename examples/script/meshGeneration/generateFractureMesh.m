%% This script is used to generate fracture meshes.

mrstModule add hfm;

%% Set relevant file paths
fracPlanesSavePath = 'examples\workspaceData\fracPlanes.mat';
processedFracPlanesSavePath = 'examples\workspaceData\processedFracPlanes.mat';
matrixMeshSavePath = 'examples\workspaceData\matrixMesh.mat';
fractureMeshSavePath = 'examples\workspaceData\fractureMesh.mat';

%% Load relevant data
load(fracPlanesSavePath, "fracPlanes");
load(matrixMeshSavePath, "G");

%% Assign fracture properties
fracLines = struct('points', {});
aperture = 5e-5;
for i = 1:length(fracPlanes)
    fracLines(i).points = fracPlanes(i).points;
    fracLines(i).aperture = aperture;
    fracLines(i).poro = 1.0;
    fracLines(i).perm = fracLines(i).aperture^2/12;
end

%% Calculate the intersection of the fracture planes with the tunnel
h = 20;
ME = 100;
[fracIds] = findIntersectTunnelFracId(fracPlanes, h, ME);
nps = [97.7, 102.3, 97.7, 102.3];
interCases = [1, 1, 2, 2];
for i = 1:length(fracIds)
    fracId = fracIds(i);
    fracFirstPoint = fracPlanes(fracId).points(1, 1:2);
    fracSecondPoint = fracPlanes(fracId).points(2, 1:2);

    distOfFirstFracPointToTunnelCenter = sqrt((fracFirstPoint(1)-ME)^2+(fracFirstPoint(2)-ME)^2);
    distOfSecondFracPointToTunnelCenter = sqrt((fracSecondPoint(1)-ME)^2+(fracSecondPoint(2)-ME)^2);
    if distOfFirstFracPointToTunnelCenter < distOfSecondFracPointToTunnelCenter
        farPoint = fracSecondPoint;
    else
        farPoint = fracFirstPoint;
    end

    [A, B, C] = calculateLineEquation([fracFirstPoint; fracSecondPoint]);
    [p] = calculateIntersectionPointOfTwoLine(A, B, C, nps(i), interCases(i));
    fracLines(fracId).points = [p 0;
                                farPoint 0;
                                farPoint 1;
                                p 1];
end
                        
save(processedFracPlanesSavePath, "fracLines");

%% Generate fracture mesh
tol = 1e-6;
[matrixFractureG, ~] = EDFMPreProcess(G, fracLines, tol);
save(fractureMeshSavePath, "matrixFractureG");