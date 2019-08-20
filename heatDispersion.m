% Description: This function finds the temperature of the environment given
%              its initial temperature, how much time has passed, and the 
%              constant of decay.
%
% Inputs: The initial temperature, the time that has passed, and the
%         constant of decay
%
% Output: The current temperature
function T =  heatDispersion(initial, t)
T = initial*exp(-0.00000121*t);
end