function [upperFaces, bottomFaces, leftFaces, rightFaces, frontFaces, backFaces, innerFaces] = findBoundaryFace3D(G, tol)
    %% Find the boundary faces of the 3D domain   

    %% Input
    % G: grid
    % tol: tolerance

    %% Output
    % upperFaces: faces on the upper boundary
    % bottomFaces: faces on the bottom boundary
    % leftFaces: faces on the left boundary
    % rightFaces: faces on the right boundary
    % frontFaces: faces on the front boundary
    % backFaces: faces on the back boundary
    % innerFaces: faces on the unlined tunnel boundary

    %% Find the boundary faces
    bf = boundaryFaces(G);

    upperFaces = bf(abs(G.faces.centroids(bf, 2)-G.ME-G.h) < tol);
    bottomFaces = bf(abs(G.faces.centroids(bf, 2)) < tol);
    leftFaces = bf(abs(G.faces.centroids(bf, 1)) < tol);
    rightFaces = bf(abs(G.faces.centroids(bf, 1)-2*G.ME) < tol);
    frontFaces = bf(abs(G.faces.centroids(bf, 3)) < tol);
    backFaces = bf(abs(G.faces.centroids(bf, 3)-1.0) < tol);
    innerFaces = setdiff(bf, [upperFaces; bottomFaces; leftFaces; rightFaces; frontFaces; backFaces]);
end