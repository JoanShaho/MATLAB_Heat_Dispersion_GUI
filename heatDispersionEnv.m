% Description: This function finds the temperature of an object given its
%              initial temperature, how much time has passed, and the 
%              constant of increase.
%
% Inputs: The initial temperature, the time that has passed, and the
%         constant of increase
%
% Output: The current temperature
function T =  heatDispersionEnv(initial, t, kenv)
T = initial*exp(kenv * t);
end