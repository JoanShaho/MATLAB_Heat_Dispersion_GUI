# MATLAB_Heat_Dispersion_GUI

- This is a simulation of how heat dissipates from an object at 50 degrees Celsius into an environment that is at 20 degrees Celsius. There are two media options that the user can choose: air and water. 

- There are 2 external functions that are responsible for changing the temperature of the environment and the object. The first one, which is responsible for increasing the temperature of the environment as time passes, is an exponential increase function where the constant of increase (kenv) depends on the environment that is chosen; it is higher for air and lower for water. Additionally, I am using a constant srate value which is responsible for mediating the widening of the graph so that it does not occur too fast or too slow with respect to how fast the simulation is proceeding.

- There are two free parameters that the user can choose. The first one is the media of the environmentwhich can be chosen through a pop-up menu with two options: “Air” and “Water”. Each media is associated with a different exponential increase constant (kenv) as well as with a different diffusion constant (srate). The second free input that the user can implement is the dimensionality of dissipation, that is in how many directions do they want the heat to dissipate.

- One last note is that at the end of the simulation for each dimensionality, the graph is not perfectly flat everywhere. This is more obvious for the 2D gaussian for which at the end the surface does not become the same color everywhere (which would mean that the temperature is the same everywhere). Instead, it still shows that the center (where the object is located) is the hottest. The reason for that is because of the nature of the exponentials used in the external functions of the temperature of the object and the environment. In other words, neither of the exponentials reaches the equilibrium temperature perfectly, but instead they get very close to it. Consequently, there will always be a peak, even if it is a small one, which would explain the reason why the graphs are behaving the way they are at the end of the simulation.
