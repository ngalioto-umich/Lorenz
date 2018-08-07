clear all, close all

nVars = 3;
polyorder = 5;
usesine = 0;

%Parameters
sigma = 10;
beta = 8/3;
rho = 28;
%Initial conditions
X0 = [-8; 7; 27]; %[x0; y0; z0]

%% Solve Lorentz system over time span (tspan)
tspan = [0.001:0.001:100];
Lorenz_sys = @(t,x)[sigma*(x(2)-x(1)); x(1)*(rho-x(3))-x(2); x(1)*x(2)-beta*x(3)];
[t, X] = ode45(Lorenz_sys, tspan, X0);

%% Differentiate using Lorenz system equations
eps = 1;
for i = 1:size(X)
    dX(i, 1) = sigma * (X(i, 2) - X(i, 1));
    dX(i, 2) = X(i, 1) * (rho - X(i, 3)) - X(i, 2);
    dX(i, 3) = X(i, 1) * X(i, 2) - beta * X(i, 3);
end
dX = dX + eps * randn(size(dX)); %addition of noise

%% Create input matrix by combining variables
Theta = poolData(X, nVars, polyorder, usesine);

%% Sparse regression
lambda = 0.025; %sparsification knob
Xi = sparsifyDynamics(Theta, dX, lambda, nVars);

%% Print out approximated model
X_list = poolDataLIST({'x','y','z'},Xi,nVars,polyorder,usesine);
Y_list = {'x_dot', 'y_dot', 'z_dot'};
printEquations(Xi, X_list, Y_list);