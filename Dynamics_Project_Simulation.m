%Dyanmics Project Simulation
%Triple Pendulum
%Ryan Caferra
%Date: 12/23/2019

%% Summary
%This script uses the equations in the Dynamics_Project_Equations script to 
%simulate the motion of a  2 dimensional triple pendulum. The script will 
%show a movie of the pendulum moving, the position and velocity of each
%link, and if energy is conserved. The movie can also be saved. Currently,
%code for saving the movie is commented out. The masses, gravity, link 
%length, and simulation time can be adjusted.

%% Assumptions
%1. Rigid bodies
%2. Frictionless joints
%3. No Air Resitance
%4. 2D motion only

%% System Parameters
clear;
close all;

global m1 m2 m3 I_cm1 I_cm2 I_cm3 L g;

% The masses of each pendulum link [kg]
m1 = 5;
m2 = 2;
m3 = 7;

%The Length of each pendulum [m]
L = 0.5;

% The moment of interia for each pendulum link [kg*m^2]
I_cm1 = 1/12 * m1 * (L/2)^2; 
I_cm2 = 1/12 * m2 * (L/2)^2;
I_cm3 = 1/12 * m3 * (L/2)^2;

%gravity [m/s^2]
g = 9.81; 

%Length of time that the simulation calculates [sec]
t0 = 0;  %Staring time
tf = 10; %Ending time

%% Initial Conditions
IC = zeros(6,1);
%All positions are in radians. 0 radians is pointing down.
%All velocities are in radians/sec.
IC(1,1) = 0;    %thetadot
IC(2,1) = pi/3;  %theta
IC(3,1) = 0;    %phidot
IC(4,1) = pi/3;  %phi
IC(5,1) = 0;    %psidot
IC(6,1) = pi/3;  %psi
t = linspace(t0, tf, 3000);
t = t';

%% Calculation

%Numerical integrator that calculates the positions and velocity of the
%triple pendulum's links. The Equations are in the pendulum_Y function
options = odeset('RelTol',1e-13,'AbsTol',1e-13);                    
[~,result] = ode45(@pendulum_Y,t,IC,options);

%Results of integrator
thd = result(:,1);
th = result(:,2);
phid = result(:,3);
phi = result(:,4);
psid = result(:,5);
psi = result(:,6);

%Plots of the results vs time
figure(1)
subplot(3,2,1)
plot(t,th);
xlabel('Time [sec]')
ylabel('Position [rad]')
title('Theta');

subplot(3,2,2)
plot(t,thd);
xlabel('Time [sec]')
ylabel('Position [rad/sec]')
title('Theta Dot');

subplot(3,2,3)
plot(t,phi);
xlabel('Time [sec]')
ylabel('Position [rad]')
title('Phi');

subplot(3,2,4)
plot(t,phid);
xlabel('Time [sec]')
ylabel('Position [rad/sec]')
title('Phi Dot');

subplot(3,2,5)
plot(t,psi);
xlabel('Time [sec]')
ylabel('Position [rad]')
title('Psi')

subplot(3,2,6)
plot(t,psid);
xlabel('Time [sec]')
ylabel('Position [rad/sec]')
title('Psi dot');

%% Simulation and Video maker
figure(2)
xlim([-2 2]);
ylim([-2 1]);
ground = line('xdata',[-1.5 1.5], 'ydata', [-1.5 -1.5]);
link1 = line('xdata',[-1 1], 'ydata', [-1 -1],'Color','red');
link2 = line('xdata',[-1 1], 'ydata', [-1 -1],'Color','blue');
link3 = line('xdata',[-1 1], 'ydata', [-1 -1],'Color','green');
title('Triple Pendulum Motion - Simulation');
axis equal

% set(gca,'nextplot','replacechildren'); 
% v = VideoWriter('Triple_Pendulum_zero.avi');
% % open(v);

for i = 1:length(t)
   set(link1,'xdata',[0 L*sin(th(i))], 'ydata', [0 -L*cos(th(i))]);
   set(link2,'xdata',[L*sin(th(i)) L*sin(th(i))+L*sin(phi(i))], 'ydata', [-L*cos(th(i)) -L*cos(th(i))-L*cos(phi(i))]);
   set(link3,'xdata',[L*sin(th(i))+L*sin(phi(i)) L*sin(th(i))+L*sin(phi(i))+L*sin(psi(i))], 'ydata', [-L*cos(th(i))-L*cos(phi(i)) -L*cos(th(i))-L*cos(phi(i))-L*cos(psi(i))]);
%    frame = getframe(gcf);
%    writeVideo(v,frame);
   pause(0.003);
end
% close(v);

%% Conservation of Energy

%Potential Energy
y1 = L/2 - L/2*cos(th);
y2 = 5/4*L - (L*cos(th) + L/4*cos(phi));
y3 = 11/4*L - (L*cos(th) + L*cos(phi) + 3/4*L*cos(psi));
PE = m1*g*y1 + m2*g*y2 + m3*g*y3;

%Kinetic Energy
vcm1 = (abs(L*thd.*cos(th)).^2/4 + abs(L*thd.*sin(th)).^2/4).^(1/2);

vcm2 = (abs((L*phid.*cos(phi))/4 + L*thd.*cos(th)).^2 + abs(L*thd.*sin(th) + ...
       (L*phid.*sin(phi))/4).^2).^(1/2);

vcm3 = (abs(L*thd.*sin(th) + L*phid.*sin(phi) + (3*L*psid.*sin(psi))/4).^2 + ...
        abs(L*phid.*cos(phi) + (3*L*psid.*cos(psi))/4 + L*thd.*cos(th)).^2).^(1/2);

KE = 0.5*m1*vcm1.^2 + 0.5*m2*vcm2.^2 + 0.5*m3*vcm3.^2 + ...
     0.5*I_cm1*thd.^2 + 0.5*I_cm2*phid.^2 + 0.5*I_cm3*psid.^2;
 
TotalE = PE + KE;
 
figure(4)
plot(t,TotalE)
xlabel('Time [sec]');
ylabel('Energy [Joules]');
title('Total Energy');

%% pendulum_Y Function
function deriv = pendulum_Y(t,input)
global m1 m2 m3 I_cm1 I_cm2 I_cm3 L g;
thd = input(1);
th = input(2);
phid = input(3);
phi = input(4);
psid = input(5);
psi = input(6);

deriv = zeros(6,1);
%theta double dot
deriv(1,1) = (288*I_cm2*L^4*m3^2*phid^2*sin(phi - th) + 16*I_cm3*L^4*m2^2*phid^2*sin(phi - th) + 1024*I_cm3*L^4*m3^2*phid^2*sin(phi - th) + 432*I_cm2*L^4*m3^2*psid^2*sin(psi - th) + 384*I_cm3*L^4*m3^2*psid^2*sin(psi - th) + 72*L^5*g*m2*m3^2*sin(2*phi - th) + 18*L^5*g*m2^2*m3*sin(2*phi - th) - 54*L^5*g*m2*m3^2*sin(2*psi - th) + 90*L^6*m2*m3^2*phid^2*sin(phi - th) + 9*L^6*m2^2*m3*phid^2*sin(phi - th) - 27*L^6*m2*m3^2*psid^2*sin(psi - th) + 32*I_cm3*L^4*m2^2*thd^2*sin(2*phi - 2*th) + 512*I_cm3*L^4*m3^2*thd^2*sin(2*phi - 2*th) + 288*I_cm2*L^4*m3^2*thd^2*sin(2*psi - 2*th) - 288*I_cm2*L^3*g*m3^2*sin(th) - 32*I_cm3*L^3*g*m2^2*sin(th) - 512*I_cm3*L^3*g*m3^2*sin(th) - 288*I_cm2*L^4*m3^2*phid^2*sin(phi - 2*psi + th) - 384*I_cm3*L^4*m3^2*psid^2*sin(psi - 2*phi + th) + 72*L^6*m2*m3^2*thd^2*sin(2*phi - 2*th) + 18*L^6*m2^2*m3*thd^2*sin(2*phi - 2*th) - 54*L^6*m2*m3^2*thd^2*sin(2*psi - 2*th) + 72*L^5*g*m1*m3^2*sin(2*psi - 2*phi + th) + 72*L^5*g*m1*m3^2*sin(2*phi - 2*psi + th) + 108*L^5*g*m2*m3^2*sin(2*psi - 2*phi + th) + 108*L^5*g*m2*m3^2*sin(2*phi - 2*psi + th) - 144*L^5*g*m1*m3^2*sin(th) - 234*L^5*g*m2*m3^2*sin(th) - 18*L^5*g*m2^2*m3*sin(th) + 54*L^6*m2*m3^2*phid^2*sin(phi - 2*psi + th) - 54*L^6*m2*m3^2*psid^2*sin(psi - 2*phi + th) + 32*I_cm3*L^3*g*m2^2*sin(2*phi - th) + 512*I_cm3*L^3*g*m3^2*sin(2*phi - th) + 288*I_cm2*L^3*g*m3^2*sin(2*psi - th) + 256*I_cm3*L^3*g*m2*m3*sin(2*phi - th) + 144*I_cm2*L^4*m2*m3*phid^2*sin(phi - th) + 320*I_cm3*L^4*m2*m3*phid^2*sin(phi - th) - 48*I_cm3*L^4*m2*m3*psid^2*sin(psi - th) + 256*I_cm3*L^4*m2*m3*thd^2*sin(2*phi - 2*th) - 288*I_cm2*L^3*g*m1*m3*sin(th) - 32*I_cm3*L^3*g*m1*m2*sin(th) - 576*I_cm2*L^3*g*m2*m3*sin(th) - 512*I_cm3*L^3*g*m1*m3*sin(th) - 832*I_cm3*L^3*g*m2*m3*sin(th) - 96*I_cm3*L^4*m2*m3*psid^2*sin(psi - 2*phi + th) - 18*L^5*g*m1*m2*m3*sin(th) + 256*I_cm2*I_cm3*L^2*m2*phid^2*sin(phi - th) + 1024*I_cm2*I_cm3*L^2*m3*phid^2*sin(phi - th) + 768*I_cm2*I_cm3*L^2*m3*psid^2*sin(psi - th) - 512*I_cm2*I_cm3*L*g*m1*sin(th) - 1024*I_cm2*I_cm3*L*g*m2*sin(th) - 1024*I_cm2*I_cm3*L*g*m3*sin(th))/(288*I_cm1*L^4*m3^2 + 288*I_cm2*L^4*m3^2 + 32*I_cm3*L^4*m2^2 + 512*I_cm3*L^4*m3^2 + 1024*I_cm1*I_cm2*I_cm3 + 72*L^6*m1*m3^2 + 234*L^6*m2*m3^2 + 18*L^6*m2^2*m3 + 576*I_cm1*I_cm2*L^2*m3 + 64*I_cm1*I_cm3*L^2*m2 + 256*I_cm2*I_cm3*L^2*m1 + 1024*I_cm1*I_cm3*L^2*m3 + 1024*I_cm2*I_cm3*L^2*m2 + 1024*I_cm2*I_cm3*L^2*m3 + 36*I_cm1*L^4*m2*m3 + 144*I_cm2*L^4*m1*m3 + 16*I_cm3*L^4*m1*m2 + 576*I_cm2*L^4*m2*m3 + 256*I_cm3*L^4*m1*m3 + 832*I_cm3*L^4*m2*m3 + 9*L^6*m1*m2*m3 - 288*I_cm1*L^4*m3^2*cos(2*phi - 2*psi) - 32*I_cm3*L^4*m2^2*cos(2*phi - 2*th) - 512*I_cm3*L^4*m3^2*cos(2*phi - 2*th) - 288*I_cm2*L^4*m3^2*cos(2*psi - 2*th) - 72*L^6*m1*m3^2*cos(2*phi - 2*psi) - 216*L^6*m2*m3^2*cos(2*phi - 2*psi) - 72*L^6*m2*m3^2*cos(2*phi - 2*th) - 18*L^6*m2^2*m3*cos(2*phi - 2*th) + 54*L^6*m2*m3^2*cos(2*psi - 2*th) - 256*I_cm3*L^4*m2*m3*cos(2*phi - 2*th));
%theta dot
deriv(2,1) = input(1,1);
%phi double dot
deriv(3,1) =  -(432*I_cm1*L^4*m3^2*psid^2*sin(phi - psi) + 384*I_cm3*L^4*m3^2*psid^2*sin(phi - psi) + 288*I_cm1*L^4*m3^2*thd^2*sin(phi - th) + 256*I_cm3*L^4*m2^2*thd^2*sin(phi - th) + 1024*I_cm3*L^4*m3^2*thd^2*sin(phi - th) + 108*L^6*m1*m3^2*psid^2*sin(phi - psi) + 378*L^6*m2*m3^2*psid^2*sin(phi - psi) + 72*L^6*m1*m3^2*thd^2*sin(phi - th) + 360*L^6*m2*m3^2*thd^2*sin(phi - th) + 144*L^6*m2^2*m3*thd^2*sin(phi - th) + 288*I_cm1*L^4*m3^2*phid^2*sin(2*phi - 2*psi) + 32*I_cm3*L^4*m2^2*phid^2*sin(2*phi - 2*th) + 512*I_cm3*L^4*m3^2*phid^2*sin(2*phi - 2*th) + 288*I_cm1*L^3*g*m3^2*sin(phi) + 128*I_cm3*L^3*g*m2^2*sin(phi) + 512*I_cm3*L^3*g*m3^2*sin(phi) + 384*I_cm3*L^4*m3^2*psid^2*sin(phi + psi - 2*th) + 288*I_cm1*L^4*m3^2*thd^2*sin(phi - 2*psi + th) + 72*L^6*m1*m3^2*phid^2*sin(2*phi - 2*psi) + 216*L^6*m2*m3^2*phid^2*sin(2*phi - 2*psi) + 72*L^6*m2*m3^2*phid^2*sin(2*phi - 2*th) + 18*L^6*m2^2*m3*phid^2*sin(2*phi - 2*th) + 180*L^5*g*m2*m3^2*sin(phi) + 72*L^5*g*m2^2*m3*sin(phi) + 72*L^5*g*m1*m3^2*sin(phi - 2*psi + 2*th) + 108*L^5*g*m2*m3^2*sin(phi - 2*psi + 2*th) + 288*I_cm1*L^3*g*m3^2*sin(phi - 2*psi) + 54*L^6*m2*m3^2*psid^2*sin(phi + psi - 2*th) + 128*I_cm3*L^3*g*m2^2*sin(phi - 2*th) + 512*I_cm3*L^3*g*m3^2*sin(phi - 2*th) + 72*L^6*m1*m3^2*thd^2*sin(phi - 2*psi + th) + 216*L^6*m2*m3^2*thd^2*sin(phi - 2*psi + th) + 108*L^5*g*m2*m3^2*sin(phi - 2*psi) + 72*L^5*g*m1*m3^2*sin(phi - 2*th) + 180*L^5*g*m2*m3^2*sin(phi - 2*th) + 72*L^5*g*m2^2*m3*sin(phi - 2*th) + 192*I_cm3*L^4*m1*m3*psid^2*sin(phi - psi) + 672*I_cm3*L^4*m2*m3*psid^2*sin(phi - psi) + 144*I_cm1*L^4*m2*m3*thd^2*sin(phi - th) + 64*I_cm3*L^4*m1*m2*thd^2*sin(phi - th) + 256*I_cm3*L^4*m1*m3*thd^2*sin(phi - th) + 1280*I_cm3*L^4*m2*m3*thd^2*sin(phi - th) + 36*L^6*m1*m2*m3*thd^2*sin(phi - th) + 256*I_cm3*L^4*m2*m3*phid^2*sin(2*phi - 2*th) + 144*I_cm1*L^3*g*m2*m3*sin(phi) + 640*I_cm3*L^3*g*m2*m3*sin(phi) + 96*I_cm3*L^4*m2*m3*psid^2*sin(phi + psi - 2*th) + 64*I_cm3*L^3*g*m1*m2*sin(phi - 2*th) + 256*I_cm3*L^3*g*m1*m3*sin(phi - 2*th) + 640*I_cm3*L^3*g*m2*m3*sin(phi - 2*th) + 36*L^5*g*m1*m2*m3*sin(phi - 2*th) + 768*I_cm1*I_cm3*L^2*m3*psid^2*sin(phi - psi) + 256*I_cm1*I_cm3*L^2*m2*thd^2*sin(phi - th) + 1024*I_cm1*I_cm3*L^2*m3*thd^2*sin(phi - th) + 256*I_cm1*I_cm3*L*g*m2*sin(phi) + 1024*I_cm1*I_cm3*L*g*m3*sin(phi))/(288*I_cm1*L^4*m3^2 + 288*I_cm2*L^4*m3^2 + 32*I_cm3*L^4*m2^2 + 512*I_cm3*L^4*m3^2 + 1024*I_cm1*I_cm2*I_cm3 + 72*L^6*m1*m3^2 + 234*L^6*m2*m3^2 + 18*L^6*m2^2*m3 + 576*I_cm1*I_cm2*L^2*m3 + 64*I_cm1*I_cm3*L^2*m2 + 256*I_cm2*I_cm3*L^2*m1 + 1024*I_cm1*I_cm3*L^2*m3 + 1024*I_cm2*I_cm3*L^2*m2 + 1024*I_cm2*I_cm3*L^2*m3 + 36*I_cm1*L^4*m2*m3 + 144*I_cm2*L^4*m1*m3 + 16*I_cm3*L^4*m1*m2 + 576*I_cm2*L^4*m2*m3 + 256*I_cm3*L^4*m1*m3 + 832*I_cm3*L^4*m2*m3 + 9*L^6*m1*m2*m3 - 288*I_cm1*L^4*m3^2*cos(2*phi - 2*psi) - 32*I_cm3*L^4*m2^2*cos(2*phi - 2*th) - 512*I_cm3*L^4*m3^2*cos(2*phi - 2*th) - 288*I_cm2*L^4*m3^2*cos(2*psi - 2*th) - 72*L^6*m1*m3^2*cos(2*phi - 2*psi) - 216*L^6*m2*m3^2*cos(2*phi - 2*psi) - 72*L^6*m2*m3^2*cos(2*phi - 2*th) - 18*L^6*m2^2*m3*cos(2*phi - 2*th) + 54*L^6*m2*m3^2*cos(2*psi - 2*th) - 256*I_cm3*L^4*m2*m3*cos(2*phi - 2*th));
%phi dot
deriv(4,1) = input(3,1);
%psi double dot
deriv(5,1) = -(384*I_cm1*L^4*m3^2*thd^2*sin(psi - th) - 384*I_cm2*L^4*m3^2*phid^2*sin(phi - psi) - 768*I_cm1*L^4*m3^2*phid^2*sin(phi - psi) + 768*I_cm2*L^4*m3^2*thd^2*sin(psi - th) - 144*L^5*g*m2*m3^2*sin(2*phi - psi) - 36*L^5*g*m2^2*m3*sin(2*phi - psi) - 192*L^6*m1*m3^2*phid^2*sin(phi - psi) - 504*L^6*m2*m3^2*phid^2*sin(phi - psi) - 18*L^6*m2^2*m3*phid^2*sin(phi - psi) + 96*L^6*m1*m3^2*thd^2*sin(psi - th) + 144*L^6*m2*m3^2*thd^2*sin(psi - th) - 72*L^6*m2^2*m3*thd^2*sin(psi - th) - 288*I_cm1*L^4*m3^2*psid^2*sin(2*phi - 2*psi) + 288*I_cm2*L^4*m3^2*psid^2*sin(2*psi - 2*th) + 384*I_cm1*L^3*g*m3^2*sin(psi) + 384*I_cm2*L^3*g*m3^2*sin(psi) + 384*I_cm2*L^4*m3^2*phid^2*sin(phi + psi - 2*th) + 384*I_cm1*L^4*m3^2*thd^2*sin(psi - 2*phi + th) - 72*L^6*m1*m3^2*psid^2*sin(2*phi - 2*psi) - 216*L^6*m2*m3^2*psid^2*sin(2*phi - 2*psi) - 54*L^6*m2*m3^2*psid^2*sin(2*psi - 2*th) + 72*L^5*g*m2*m3^2*sin(psi) - 36*L^5*g*m2^2*m3*sin(psi) + 96*L^5*g*m1*m3^2*sin(psi - 2*phi + 2*th) + 144*L^5*g*m2*m3^2*sin(psi - 2*phi + 2*th) + 36*L^5*g*m2^2*m3*sin(psi - 2*phi + 2*th) - 72*L^6*m2*m3^2*phid^2*sin(phi + psi - 2*th) - 18*L^6*m2^2*m3*phid^2*sin(phi + psi - 2*th) + 384*I_cm2*L^3*g*m3^2*sin(psi - 2*th) + 96*L^6*m1*m3^2*thd^2*sin(psi - 2*phi + th) + 288*L^6*m2*m3^2*thd^2*sin(psi - 2*phi + th) + 72*L^6*m2^2*m3*thd^2*sin(psi - 2*phi + th) + 96*L^5*g*m1*m3^2*sin(psi - 2*th) + 72*L^5*g*m2*m3^2*sin(psi - 2*th) - 36*L^5*g*m2^2*m3*sin(psi - 2*th) - 384*I_cm1*L^3*g*m3^2*sin(2*phi - psi) - 96*I_cm1*L^3*g*m2*m3*sin(2*phi - psi) - 48*I_cm1*L^4*m2*m3*phid^2*sin(phi - psi) - 192*I_cm2*L^4*m1*m3*phid^2*sin(phi - psi) - 672*I_cm2*L^4*m2*m3*phid^2*sin(phi - psi) - 48*I_cm1*L^4*m2*m3*thd^2*sin(psi - th) + 192*I_cm2*L^4*m1*m3*thd^2*sin(psi - th) + 768*I_cm2*L^4*m2*m3*thd^2*sin(psi - th) - 12*L^6*m1*m2*m3*phid^2*sin(phi - psi) - 12*L^6*m1*m2*m3*thd^2*sin(psi - th) - 48*I_cm1*L^3*g*m2*m3*sin(psi) + 384*I_cm2*L^3*g*m2*m3*sin(psi) + 96*I_cm2*L^4*m2*m3*phid^2*sin(phi + psi - 2*th) + 96*I_cm1*L^4*m2*m3*thd^2*sin(psi - 2*phi + th) + 24*L^5*g*m1*m2*m3*sin(psi - 2*phi + 2*th) + 192*I_cm2*L^3*g*m1*m3*sin(psi - 2*th) + 384*I_cm2*L^3*g*m2*m3*sin(psi - 2*th) + 24*L^6*m1*m2*m3*thd^2*sin(psi - 2*phi + th) - 12*L^5*g*m1*m2*m3*sin(psi - 2*th) - 768*I_cm1*I_cm2*L^2*m3*phid^2*sin(phi - psi) + 768*I_cm1*I_cm2*L^2*m3*thd^2*sin(psi - th) + 768*I_cm1*I_cm2*L*g*m3*sin(psi))/(288*I_cm1*L^4*m3^2 + 288*I_cm2*L^4*m3^2 + 32*I_cm3*L^4*m2^2 + 512*I_cm3*L^4*m3^2 + 1024*I_cm1*I_cm2*I_cm3 + 72*L^6*m1*m3^2 + 234*L^6*m2*m3^2 + 18*L^6*m2^2*m3 + 576*I_cm1*I_cm2*L^2*m3 + 64*I_cm1*I_cm3*L^2*m2 + 256*I_cm2*I_cm3*L^2*m1 + 1024*I_cm1*I_cm3*L^2*m3 + 1024*I_cm2*I_cm3*L^2*m2 + 1024*I_cm2*I_cm3*L^2*m3 + 36*I_cm1*L^4*m2*m3 + 144*I_cm2*L^4*m1*m3 + 16*I_cm3*L^4*m1*m2 + 576*I_cm2*L^4*m2*m3 + 256*I_cm3*L^4*m1*m3 + 832*I_cm3*L^4*m2*m3 + 9*L^6*m1*m2*m3 - 288*I_cm1*L^4*m3^2*cos(2*phi - 2*psi) - 32*I_cm3*L^4*m2^2*cos(2*phi - 2*th) - 512*I_cm3*L^4*m3^2*cos(2*phi - 2*th) - 288*I_cm2*L^4*m3^2*cos(2*psi - 2*th) - 72*L^6*m1*m3^2*cos(2*phi - 2*psi) - 216*L^6*m2*m3^2*cos(2*phi - 2*psi) - 72*L^6*m2*m3^2*cos(2*phi - 2*th) - 18*L^6*m2^2*m3*cos(2*phi - 2*th) + 54*L^6*m2*m3^2*cos(2*psi - 2*th) - 256*I_cm3*L^4*m2*m3*cos(2*phi - 2*th));
%psi dot
deriv(6,1) = input(5,1);

end