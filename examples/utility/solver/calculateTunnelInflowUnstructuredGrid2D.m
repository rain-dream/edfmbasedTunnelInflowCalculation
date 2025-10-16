function [q] = calculateTunnelInflowUnstructuredGrid2D(G, states)
    %% Calculate tunnel inflow rate on 2D unstructured grid

    %% Input
    % G: grid
    % states: states

    %% Output
    % q: tunnel inflow rate

    tunnelBoundaryFaces = findTunnelBoundarySurfaces(G, 1e-2);

    q = sum(abs(states{1}.flux(tunnelBoundaryFaces)));
end


function [tunnelBoundaryFaces] = findTunnelBoundarySurfaces(G, tol)
    %% Find tunnel boundary surfaces
    
    %% Input
    % G: grid
    % tol: tolerance

    %% Output
    % tunnelBoundaryFaces: tunnel boundary faces

    %% Find the boundary faces
    bf = boundaryFaces(G);

    tunnelCenterCoord = [G.ME, G.ME];
    distanceFromTunnelCenter = sqrt((G.faces.centroids(bf, 1)-tunnelCenterCoord(1)).^2+(G.faces.centroids(bf, 2)-tunnelCenterCoord(2)).^2);
    
    tunnelBoundaryFaces = bf(abs(distanceFromTunnelCenter-G.r) < tol);
end