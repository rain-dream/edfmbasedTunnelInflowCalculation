function [upperFaces, bottomFaces, leftFaces, rightFaces, innerFaces] = findBoundaryFace2D(G, tol)
    %% Find the boundary faces of the 2D domain   

    %% Input
    % G: grid
    % tol: tolerance

    %% Output
    % upperFaces: faces on the upper boundary
    % bottomFaces: faces on the bottom boundary
    % leftFaces: faces on the left boundary
    % rightFaces: faces on the right boundary
    % innerFaces: faces on the unlined tunnel boundary

    %% Find the boundary faces
    bf = boundaryFaces(G);

    upperFaces = bf(abs(G.faces.centroids(bf, 2)-G.ME-G.h) < tol);
    bottomFaces = bf(abs(G.faces.centroids(bf, 2)) < tol);
    leftFaces = bf(abs(G.faces.centroids(bf, 1)) < tol);
    rightFaces = bf(abs(G.faces.centroids(bf, 1)-2*G.ME) < tol);
    innerFaces = setdiff(bf, [upperFaces; bottomFaces; leftFaces; rightFaces]);
end