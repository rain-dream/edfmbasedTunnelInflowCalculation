function [G] = generateRegularCartesianGrid(cellDim, physDim)
    %% Generate a structured grid

    %% Input
    % cellDim: cell dimensions 
    % physDim: physical dimensions

    %% Output
    % G: grid
    
    G = cartGrid(cellDim, physDim);
    G = computeGeometry(G);
end