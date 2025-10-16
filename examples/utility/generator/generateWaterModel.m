function [waterModel] = generateWaterModel(G)
    %% Generate water model

    %% Output
    % waterModel: water model

    %% Load relevant modules
    mrstModule add hfm ad-blackoil ad-core ad-props mrst-gui

    %% Setup fluid model with water properties
    fluid = initSimpleADIFluid('phases', 'W', ...
    'mu', 1*centi*poise, ...
    'rho', 1000*kilogram/meter^3, ...
    'pRef', 1*barsa, ...
    'c', 0/barsa);

    %% Setup water model
    waterModel = WaterModel(G, G.rock, fluid);
end