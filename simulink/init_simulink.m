M = 0.2173; % mass
L = 0.0045; % inductance
const_z = 90.5186; % maglev parameters
const_i = 0.212779;
% const_z = 28.41
% const_i = 0.08
Re = 0.556; % resistance

% state variable u = [position, velocity, current]



E = [1 0 0;
     0 M 0;
     0 0 L];

A = [0        1  0;
     const_z  0  const_i;
     0        0 -Re];
 
B = [0;
     0;
     1];
 
C = eye(3);

D = [0;0;0];

plantsys = ss(E\A, E\B, C, D);  

Ts = 1.E-2; %sampling rate 

dplantsys = c2d(plantsys, Ts);

Ad = dplantsys.a; 
Bd = dplantsys.b;
Cd = dplantsys.c;
Dd = dplantsys.d;
% mpcDesigner;

Alqr = [Ad zeros(3, 1); Ts 0 0 1];
Blqr = [Bd; 0];
Q = diag([1e8; 1e4; 0; 2e11]);
R = [1];

Kfb = dlqr(Alqr, Blqr, Q, R);

% Kdlqr = dlqr(Ad, Bd, diag([1,11]), 1);
% Krd = 1/(Cd*(inv((eye(3)-(Ad-Bd*Kdlqr))))*Bd);
% Krd = Krd(1, 1);
% As = [0,1,0;416.560515416475,0,0.979194661757938;0,0,-123.555555555556]
% Bs = [0;0;222.222222222222]
% Cs = [1,0,0]