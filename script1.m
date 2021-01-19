M = 0.2173
L = 0.0045
const_z = 90.5186
const_i = 0.212779
% const_z = 28.41
% const_i = 0.08
Re = 0.556



E = [1, 0,0;
    0, M, 0;
    0, 0, L];

A = [0,1,0;
    const_z, 0, const_i;
    0,0,-Re];
B = [0;
    0;
    1];
C = [1,0,0;
    1,0,0;
    -1,0,0;
    -1,0,0];
D = 0; 

Ein = inv(E);



Atilda = mtimes(Ein,A);
Btilda = mtimes(Ein,B); 

plantsys = ss(Atilda, Btilda, C, D);  

deltat = 1.0*10^(-2); %sampling rate 

dplantsys = c2d(plantsys, deltat);

Ad = dplantsys.a; 
Bd = dplantsys.b;
Cd = dplantsys.c;
Dd = dplantsys.d;
%mpcDesigner;

%Kdlqr = dlqr(Ad, Bd, diag([100,10,1000]), 3);
Kdlqr = dlqr(Ad, Bd, diag([100,10,2]), 1); %good
%Kdlqr = dlqr(Ad, Bd, diag([1,1,10000000000]), 10000000000); %for V5
%Kdlqr = dlqr(Ad, Bd, diag([1000000,500000,2]), 1);
Krd = 1/(Cd*(inv((eye(3)-(Ad-Bd*Kdlqr))))*Bd);
Krd = Krd(1, 1);
As = [0,1,0;416.560515416475,0,0.979194661757938;0,0,-123.555555555556]
Bs = [0;0;222.222222222222]
Cs = [1,0,0]
Q = 2.3;
%Q = 0;
R = 5e-07;
%N = [5e-07, 0, 0, 0;
%    0, 5e-07, 0, 0;
%    0, 0, 5e-07, 0];
N = 0;
MeasurementOffset = .095;
Ce = eye(3);


Eplus = [1, 0,0,0;
    0, M, 0,0;
    0, 0, L,0
   0,0,0,1];


Aplus = [0,1,0,0;
    const_z, 0, const_i,0;
    0,0,-Re,0
    1,0,0,0];
Bplus = [0;
    0;
    1;
    0];
Cplus = [1,0,0,0];
D = 0; 

plantsysplus = ss(Eplus\Aplus, Eplus\Bplus, Cplus, D); 
dplantsysplus = c2d(plantsysplus, deltat);

Adplus = dplantsysplus.a; 
Bdplus = dplantsysplus.b;
Cdplus = dplantsysplus.c;

Kdp = dlqr(Adplus,Bdplus,diag([1e6; 1e3; 0; 1e9]),1);



