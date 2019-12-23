%Dynamics Project Equations
%Triple Pendulum
%Ryan Caferra
%Date: 12/23/2019

%% Summary
%This script creates the equations to be used by the
%Dynamics_Project_Simulation script. 

%% Assumptions
%1. Rigid bodies
%2. Frictionless joints
%3. No Air Resitance
%4. 2D motion only


syms m1 m2 m3 I_cm1 I_cm2 I_cm3 th thd thdd phi phid phidd...
     psi psid psidd Rx Ry Fx Fy Gx Gy L g

%Unit vectors
i = [1 0 0];
j = [0 1 0];
k = [0 0 1];
u1 = sin(th)*i - cos(th)*j;
u2 = cos(th)*i + sin(th)*j;
u3 = sin(phi)*i - cos(phi)*j;
u4 = cos(phi)*i + sin(phi)*j;
u5 = sin(psi)*i - cos(psi)*j;
u6 = cos(psi)*i + sin(psi)*j;

%Position Vectors
%Link 1
ra_cm1 = -L/2*u1;
rb_cm1 = -ra_cm1;
%Link 2
rb_cm2 = 1/4*L*u3;
rc_cm2 = 3/4*L*u3;
%Link 3
rc_cm3 = 3/4*L*u5;

%Force Vectors
R = Rx*i + Ry*j;
F = Fx*i + Fy*j;
G = Gx*i + Gy*j;

%Center of Mass's Acceleration
acm1 = L/2*thdd*u2 - L/2*thd^2*u1;
acm2 = L*thdd*u2 - L*thd^2*u1 + L/4*phidd*u4 - L/4*phid^2*u3;
acm3 = L*thdd*u2 - L*thd^2*u1 + L*phidd*u4 - L*phid^2*u3 + 3*L/4*psidd*u6 - 3*L/4*psid^2*u5;

alpha1 = thdd*k;
alpha2 = phidd*k;
alpha3 = psidd*k;

%Linear Momentum Balance Link 1
eqn1 = m1*acm1 - (R-F-m1*g*j);
EQN1 = eqn1(1);
EQN2 = eqn1(2);

%Angluar Momentum Balance Link 1
% eqn2 = I_cm1*alpha1 - (cross(ra_cm1,R) + cross(rb_cm1,-F));
eqn2 = I_cm1*alpha1 - (cross(-L/2*u1,R) + cross(L/2*u1,-F));
EQN3 = eqn2(3);

%Linear Momentum Balance Link 2
eqn3 = m2*acm2 - (F-G-m2*g*j);
EQN4 = eqn3(1);
EQN5 = eqn3(2);

%Angular Momentum Balance Link 2
% eqn4 = I_cm2*alpha2 - (cross(rb_cm2,F) + cross(rc_cm2,-G));
eqn4 = I_cm2*alpha2 - (cross(-L/4*u3,F) + cross(3/4*L*u3,-G));
EQN6 = eqn4(3);

%Linear Momentum Balance Link 3
eqn5 = m3*acm3 - (G-m3*g*j);
EQN7 = eqn5(1);
EQN8 = eqn5(2);

%Angular Momentum Balance Link 3
% eqn6 = I_cm3*alpha3 - cross(rc_cm3,F);
eqn6 = I_cm3*alpha3 - cross(-L*3/4*u5,G);
EQN9 = eqn6(3);

b1 = -subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});
b2 = -subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});
b3 = -subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});
b4 = -subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});
b5 = -subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});
b6 = -subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});
b7 = -subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});
b8 = -subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});
b9 = -subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 0});

%'A' Matrix
a11 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b1;
a12 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b1;
a13 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b1;
a14 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b1;
a15 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b1;
a16 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b1;
a17 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b1;
a18 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b1;
a19 = subs(EQN1,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b1;

a21 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b2;
a22 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b2;
a23 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b2;
a24 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b2;
a25 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b2;
a26 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b2;
a27 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b2;
a28 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b2;
a29 = subs(EQN2,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b2;

a31 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b3;
a32 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b3;
a33 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b3;
a34 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b3;
a35 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b3;
a36 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b3;
a37 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b3;
a38 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b3;
a39 = subs(EQN3,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b3;

a41 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b4;
a42 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b4;
a43 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b4;
a44 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b4;
a45 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b4;
a46 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b4;
a47 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b4;
a48 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b4;
a49 = subs(EQN4,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b4;

a51 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b5;
a52 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b5;
a53 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b5;
a54 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b5;
a55 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b5;
a56 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b5;
a57 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b5;
a58 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b5;
a59 = subs(EQN5,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b5;

a61 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b6;
a62 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b6;
a63 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b6;
a64 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b6;
a65 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b6;
a66 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b6;
a67 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b6;
a68 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b6;
a69 = subs(EQN6,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b6;

a71 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b7;
a72 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b7;
a73 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b7;
a74 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b7;
a75 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b7;
a76 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b7;
a77 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b7;
a78 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b7;
a79 = subs(EQN7,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b7;

a81 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b8;
a82 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b8;
a83 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b8;
a84 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b8;
a85 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b8;
a86 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b8;
a87 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b8;
a88 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b8;
a89 = subs(EQN8,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b8;

a91 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{1, 0, 0, 0, 0, 0, 0, 0, 0}) + b9;
a92 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 1, 0, 0, 0, 0, 0, 0, 0}) + b9;
a93 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 1, 0, 0, 0, 0, 0, 0}) + b9;
a94 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 1, 0, 0, 0, 0, 0}) + b9;
a95 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 1, 0, 0, 0, 0}) + b9;
a96 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 1, 0, 0, 0}) + b9;
a97 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 1, 0, 0}) + b9;
a98 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 1, 0}) + b9;
a99 = subs(EQN9,{Rx, Ry, Fx, Fy, Gx, Gy, thdd, phidd, psidd},{0, 0, 0, 0, 0, 0, 0, 0, 1}) + b9;

A = [[a11 a12 a13 a14 a15 a16 a17 a18 a19];...
     [a21 a22 a23 a24 a25 a26 a27 a28 a29];...
     [a31 a32 a33 a34 a35 a36 a37 a38 a39];...
     [a41 a42 a43 a44 a45 a46 a47 a48 a49];...
     [a51 a52 a53 a54 a55 a56 a57 a58 a59];...
     [a61 a62 a63 a64 a65 a66 a67 a68 a69];...
	 [a71 a72 a73 a74 a75 a76 a77 a78 a79];...
	 [a81 a82 a83 a84 a85 a86 a87 a88 a89];...
	 [a91 a92 a93 a94 a95 a96 a97 a98 a99]];

b = [b1; b2; b3; b4; b5; b6; b7; b8; b9];

x = inv(A)*b;
x_simp = simplify(x);
fprintf(' Theta double dot = ')
disp(x_simp(7))
fprintf(' Phi double dot = ')
disp(x_simp(8))
fprintf(' Psi double dot = ')
disp(x_simp(8))
% x_simp(7)
% x_simp(8)
% x_simp(9)