function [states] = rectDomainWithoutTunnelWithFracturesBC1Solver(G, fluidModel, solutionSavePath)
    %% Steady state single phase flow solver for rectangular domain without tunnel with fractures

    %% Input
    % G: grid structure
    % fluidModel: fluid model
    % solutionSavePath: path to save the solution

    %% Output
    % states: solution
    
    %% Setup gravity
    gravity reset off;
    
    %% Set up initial and boundary conditions
    pRef = 1*barsa;

    % Initial condition
    state = initResSol(G, pRef);

    % Find fracture cell faces at domain boundary
    tol = 1e-6;
    boundfaces = findfracboundaryfaces(G, tol);

    % Set pressure differential on opposing boundaries in the x-direction
    deltaP = 1*barsa;
    bc = [];
    bc = pside(bc, G.Matrix, 'East', pRef);
    bc = pside(bc, G.Matrix, 'West', pRef+deltaP);
    bc = addBC(bc, boundfaces.East, 'Pressure', pRef);
    bc = addBC(bc, boundfaces.West, 'Pressure', pRef+deltaP);
    bc.sat = ones(size(bc.face));

    states = steadySinglePhaseFlowSolver(G, fluidModel, state, bc, true, solutionSavePath);
end