# Table of Contents

## 1. addExpense

### Purpose
The purpose is to add up expenses based on an assigned catagory using Excel VBA. Ex. Gas payments would be in the Car catagory

### Inputs
addExpense(expenseName As String, expenseCosts As Range, expenseCatagory As Range)

- The expense catagory's name that is being summed (expenseName)
- The cost of each expense as a single column (expenseCosts)
- The catagory of each expense as a single column (expenseCatagory)

### Outputs
- (Double) The total cost of the chosen expense catagory 
- (String) An error message if: 
    - the lists of the expenses' costs and catagories aren't the same size
    - the lists are not columns
    - there is a non-numeric value in the cost list
    - there is a non-text value in the catagory list
    
### Associated Files
 - [Code](https://github.com/rac2892/collection/blob/master/addExpense%20Function%20Code.md)
 - [Example Excel File](https://github.com/rac2892/collection/blob/master/addExpense%20Testing.xlsm)

## 2. Dynamics Project

### Purpose
The purpose of these scripts is to demonstrate the motion of a pendulum with 3 links (Triple Pendulum) using MATLAB 2018a. 
### Inputs
1. The Equations script has no inputs
2. The Simulation
    - script uses the angular acceleration equations calculated in the Equations script to generate the simulation.
    - changable parameters
        - Link masses
        - gravity
        - starting time
        - Ending time
        - Link length (all links are the same length)
### Outputs
1. A movie of the pendulum moving. Can be saved. Currently the movie saving code is commented out
2. A graph of the position and velocity of each link
3. A graph showing if energy is conserved.

### Associated Files
 - [Simulation Script](https://github.com/rac2892/collection/blob/master/Dynamics_Project_Simulation.m)
 - [Equations Script](https://github.com/rac2892/collection/blob/master/Dynamics_Project_Equations.m)
 
## 3. Runge Kutta 4th Order

### Purpose
### Inputs
### Outputs
### Associated Files
