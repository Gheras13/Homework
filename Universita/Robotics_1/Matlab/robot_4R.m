% dynamic model of a spatial 4R elbow-type robot
% using a Lagrangian formulation in symbolic form

% assumptions:
% - frames assigned according to standard DH (see figure in Short Projects)
% - center of masses on link axes
% - diagonal link inertias (with Iyy=Izz (≠ Ixx) for links 2, 3, and 4)
% - gravity is present along -z0
% numerical data at the end of the file

clear all
close all
clc

% kinematics (limited to rotation matrices used for angular velocity 
% in recursive algorithm for kinetic energy computation, if used)

syms alpha d a theta real
syms L1 L2 L3 L4 a1 real

disp('**** dynamic model of 4R spatial robot ****')
disp(' ')
disp('[press return to proceed at every pause (or comment them all)]')
pause

N = 4;  % number of joints 

DHTABLE = [ pi/2      0      sym('L1') sym('q1');  % Giunto 1
             0     sym('L2')    0      sym('q2');  % Giunto 2
             0     sym('L3')    0      sym('q3');  % Giunto 3
             0     sym('L4')    0      sym('q4')]; % Giunto 4

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
T4 = A{4} % Quarta trasformazione omogenea

% Prodotto totale delle trasformazioni
T_tot = simplify(T1 * T2 * T3 * T4);

disp('Total homogeneous transformation matrix (base to end-effector):')
T_tot
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

% Equazioni per la cinematica inversa
IK_eqns = [x == x_d, y == y_d, z == z_d];

% Risoluzione delle equazioni per q1, q2, q3, q4
IK_sol = solve(IK_eqns, [sym('q1'), sym('q2'), sym('q3'), sym('q4')]);

disp('Solutions for inverse kinematics:')
disp(IK_sol)
