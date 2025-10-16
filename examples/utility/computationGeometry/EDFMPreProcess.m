function [processedG, processedFracPlanes] = EDFMPreProcess(G, fracPlanes, tol)
    %% EDFM pre-processing

    %% Input
    % G: grid
    % fracPlanes: fracture data
    % tol: tolerance

    %% Output
    % processedG: processed grid
    % processedFracPlanes: processed fracture data

    %% Load relevant modules
    mrstModule add hfm ad-blackoil ad-core ad-props mrst-gui

    [processedG, processedFracPlanes] = EDFMgrid(G, fracPlanes,'Tolerance', tol);
    processedG = fracturematrixNNC3D(processedG, tol);
    [processedG, processedFracPlanes] = fracturefractureNNCs3D(processedG, processedFracPlanes, tol);   
end