function [q] = calculateTunnelInflowStructuredGrid3DWithoutCrossingFracture(G, states)
    %% Calculate tunnel inflow rate on 3D structured grid without crossing fracture

    %% Input
    % G: grid
    % states: states

    %% Output
    % q: tunnel inflow rate 

    [~, ~, ~, ~, ~, ~, tunnelBoundaryFaces] = findBoundaryFace3D(G, 1e-5);

    q = sum(abs(states{1}.flux(tunnelBoundaryFaces)));
end