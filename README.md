# Reproducible Case
This repository contains the MATLAB source code and a minimal working example for the paper "Coupled effects of
fracture spatial distribution and rock matrix permeability on tunnel water inflow: An EDFM-based investigation". It implements an embedded discrete fracture model (EDFM)-based method for simulating steady-state groundwater inflow into a tunnel in fractured rock masses.

## 1 Case Configuration
### 1.1 Model Domain & Boundary Conditions
- Domain size: 200 m × 120 m (width × height)
- Tunnel: circular, radius = 3 m, centered at (100, 100)
- Boundary conditions:
  - Fixed pressure head at top boundary: 0 m
  - Constant pressure head at bottom boundary: 120 m
  - Linearly varying pressure at lateral boundaries
### 1.2 Fracture Network Parameters
- Fracture aperture: 0.05 mm
- Fracture spacing: 8 m
- Fracture dip angle: 40°
- fracture-to-matrix permeability ratio: 1000

## 2 Quick Start Guide
### 2.1 Prerequisites
- MATLAB [R2023b] or later

### 2.2 Running the Code
1. Clone the repository

   `git clone https://github.com/rain-dream/edfmbasedTunnelInflowCalculation.git`

2. Run `startup.m` to initialize configuration
3. Navigate to the `examples\script` folder
- 3.1 Run `computationalDomainGeneration\generateFracture.m` to generate the computational domain
- 3.2 Run `meshGeneration\generateMatrixMesh.m` to to generate matrix meshes
- 3.3 Run `meshGeneration\generateFractureMesh.m` to to generate fracture meshes
- 3.4 Run `tunnelInflowSolution\solve.m` to to solve the flow problem
- 3.5 Run `tunnelInflowSolution\computeTunnelInflow.m` to obtain tunnel water inflow
- 3.6 Run `computationalDomainGeneration\plotGeometryofComputationalDomain.m.m` to plot the geomtry of the computational domain
- 3.7 Run `meshGeneration\plotMesh.m` to plot the meshes
- 3.8 Run `tunnelInflowSolution\plotPressureField.m` to plot the pressure field

### 2.3 Expected Output
After successful execution, the code will generate:
- `\examples\workspaceData\fracPlanes.mat`: data of the fracture planes
- `\examples\workspaceData\matrixMesh.mat`: data of the matrix mesh
- `\examples\workspaceData\fracMesh.mat`: data of the fracture mesh
- `\examples\workspaceData\solution.mat`: data of the solution states
- `\examples\script\computationalDomainGeneration\fig\computationalDomain.tif`: the figure of the geometry of the computational domain
- `\examples\script\meshGeneration\fig\mesh.tif`: the figure of the mesh of the computational domain
- `\examples\script\tunnelInflowSolution\fig\pressureField.tif`: the figure of the pressure field of the computational domain
The compute tunnel inflow rate per unit length on our machine is 1.0214×10<sup>-4</sup> m<sup>3</sup>/s/m.

## 3 License
This project is licensed under the [GPL-3.0 License]. 

## 4 Contact
For questions regarding this code implementation, please contact:
- Name: Zhang Yu
- Email: zhangyu_geoboy@163.com
- GitHub Issues: [Please use the GitHub issue tracker]

