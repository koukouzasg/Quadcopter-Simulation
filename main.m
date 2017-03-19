clear;
clc;

eye3 = eye(3);
i = eye3(:, 1);
j = eye3(:, 2);
k = eye3(:, 3);

M = 1;
G = 9.81;
F = 20 * k;
d = 0.25;
MAX_ITER = 50;
DT = 0.05;

DIM_X = 50;
DIM_Y = 50;
DIM_Z = 50;
ROD_LENGTH = 10;

I = diag([5e-3,5e-3,10e-3]); %Inertia matrix
ct= 0.0014;                  %thrust
cq = 3.2904e-07;             %torque

T = 0;
t = [1;1;1];

omega_engine = zeros(4,1);   %power of the motors
omega_dot = zeros(3,1);      %angular accel of the drone
omega = zeros(3,1);          %angular velocity of the drone
theta_dot = zeros(3,1);
Theta = zeros(3,1);

gamma = [ct, ct, ct, ct;
         0, d*ct,0 , -d*ct;
         -d*ct, 0, d*ct,0;
         -cq , cq , -cq , cq;];


phi = 0;
theta = 0;
psi = 0;

v = zeros(3, 1);
x = zeros(3, 1);

figure

for i = 1:MAX_ITER
    T=M*G;
    matrix = [T; t(1); t(2); t(3)];
    omega_engine = inv(gamma)*matrix ; 
    
    omega_dot = I\(cross(-omega,I*omega) + t) ;
    omega = omega + omega_dot*DT;
    
    omega_e =  [0 , -sin(psi), cos(psi)*cos(theta);
                0, cos(psi), sin(psi)*sin(theta);
                1, 0 , -sin(theta)];
    theta_dot = inv(omega_e)*omega;
    Theta = Theta + theta_dot * DT;
    
    
    v_dot = (M * G * (-k) + rotation(psi, theta, phi) * F) / M;
    
    v = v + v_dot * DT;
    x = x + v * DT;
    
    plotDrone(x(1), x(2), x(3), ROD_LENGTH);
    axis([-DIM_X DIM_X -DIM_Y DIM_Y -0 DIM_Z]);
    grid on;
    hold off;
    
    pause(0.016);
end

