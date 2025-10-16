function [faces] = findSpecifiedCentroidMatrixFaces(G, centroids, tol)
    faceNum = size(centroids, 1);
    faces = zeros(faceNum, 1);
    idxFaces = 1:G.faces.num;

    for i = 1:faceNum
        faces(i) = idxFaces(abs(G.faces.centroids(idxFaces, 1)-centroids(i, 1))+abs(G.faces.centroids(idxFaces, 2)-centroids(i, 2))<tol);
    end
end