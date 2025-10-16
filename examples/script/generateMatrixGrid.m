%% Parameter setting
h = 20;                     % groundwater head above the tunnel centerline
z = 20;                     % tunnel depth
ME = 100;                    % model extent
r = 3;                      % tunnel radius

xLimits = [0, ME-2*r, ME+2*r, 2*ME];
xResolutions = [1, 0.05, 1];
yLimits = [0, ME-2*r, ME+2*r, z+ME];
yResolutions = [1, 0.05, 1];
zLimits = [0, 1];
zResolutions = [1];
tunnelCenter = [ME, ME, 0.5];

apertures = [1e-4, 1.75e-4, 3.75e-4, 1.5e-3];
matrixToFracturePermRatios = [10^-3, 10^-4, 10^-5, 10^-6];
for i = [1 4]
    for j = 1:4
        matrixToFracturePermRatio = matrixToFracturePermRatios(j);
        rockPerm = matrixToFracturePermRatio*(apertures(i)^2/12);  % permeability of the rock
        rockPoro = 0.3;                                            % porosity of the rock

        %% Generate a 3D structured grid for an unlined tunnel with a circular cross-section
        G = generateUnlinedTunnelStructuredGrid3D(xLimits, xResolutions, yLimits, yResolutions, zLimits, zResolutions, tunnelCenter, r);
        G.h = h;
        G.z = z;
        G.ME = ME;
        G.r = r;
        G.rock = makeRock(G, rockPerm, rockPoro);

        %% Save the grid
        matrixGridSaveMatPath = strcat('D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixGrid', num2str((i-1)*4+j), '.mat');
        if ~isempty(matrixGridSaveMatPath)
            save(matrixGridSaveMatPath, 'G');
        end
    end
end