% dynamic model of a spatial 3R elbow-type robot
% using a Lagrangian formulation in symbolic form

% assumptions:
% - frames assigned according to standard DH (see figure in Short Projects)
% - center of masses on link axes
% - diagonal link inertias (with Iyy=Izz (≠ Ixx) for links 2 and 3)
% - gravity is present along -z0
% numerical data at the end of the file

clear all
close all
clc

% kinematics (limited to rotation matrices used for angular velocity 
% in recursive algorithm for kinetic energy computation, if used)

syms alpha d a theta real
syms L1 L2 L3 real

disp('**** dynamic model of 3R spatial elbow-type robot ****')
disp(' ')
disp('[press return to proceed at every pause (or comment them all)]')
pause

N=3;  % number of joints 

DHTABLE = [ pi/2      0      sym('L1') sym('q1');
             0     sym('L2')    0      sym('q2');
             0     sym('L3')    0      sym('q3')];

TDH = [ cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
        sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
          0             sin(alpha)             cos(alpha)            d;
          0               0                      0                   1];

for i = 1:N
    alpha = DHTABLE(i,1);
    a = DHTABLE(i,2);
    d = DHTABLE(i,3);
    theta = DHTABLE(i,4);
    A{i} = simplify(subs(TDH)); % semplifica la trasformazione omogenea
end

disp(' ')
disp('* DH homogeneous transformation matrices *')

T1 = A{1} % Prima trasformazione omogenea
T2 = A{2} % Seconda trasformazione omogenea
T3 = A{3} % Terza trasformazione omogenea
T_tot = simplify(T1 * T2 * T3) % Prodotto delle tre trasformazioni
pause

disp(' ')
disp('* Extracting position from T_tot *')

% Calcolo della posizione (x, y, z)
x = T_tot(1, 4); % Coordinate x
y = T_tot(2, 4); % Coordinate y
z = T_tot(3, 4); % Coordinate z

disp('Position of the end-effector:')
fprintf('x = %s\n', char(x));
fprintf('y = %s\n', char(y));
fprintf('z = %s\n', char(z));

disp(' ')
disp('* Solving inverse kinematics *')

% Definizione della posizione desiderata
x_d = 0.5; % Posizione x desiderata
y_d = 0.4; % Posizione y desiderata
z_d = 0.6; % Posizione z desiderata



