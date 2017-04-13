% Electric Circuits II - RLC Parallel Circuit Natural Response 
% Author : Mohamed Rashad
%--------------------------------------------------------------
% L = ?
% C = ?
% R = ? 
% t = ?
% 
% a=1/(2*R*C)
% w0 = 1/sqrt(L*C)
% wd = sqrt(w0*w0 - a*a) 
% 
% s1 = -a + wd
% s2 = -a - wd
%--------------------------------------------------------------
syms a1 a2 b1 b2 d1 d2 t

%-------------------------------------------------------------
%Solve for overdamped response
%-------------------------------------------------------------

R = 200;C = 0.0000002;
L = 0.05;
w0 = 1/sqrt(L*C);
a=1/(2*R*C);
wd = sqrt(a*a - w0*w0);
s1 = -a + wd;
s2 = -a - wd;

eqn1 = a1 + a2 == 12;
eqn2 = s1 * a1 + s2 * a2 == -450000;
 
sol = solve([eqn1, eqn2], [a1 , a2 ]);
A1 = sol.a1;
A2 = sol.a2;

V_overdamped = A1 * exp((s1 * t)) + A2 * exp((s2 * t))
% 
% %------------------------------------------------------------
% % Solve for crtitcally damped response
% %-------------------------------------------------------------
R = 4000;
C = 0.000000125;
L = 8;

a=1/(2*R*C)
w0 = 1/sqrt(L*C);

wd = - sqrt(a*a - w0*w0) * j;
s1 = -a + wd * j;
s2 = -a - wd * j;

D2 = 0;
D1 = 98000;

V_crticaldamped =  D1  * t * exp(-a * t)

% %-------------------------------------------------------------
% % Solve for underdamped response
% %-------------------------------------------------------------
R = 20000;
C = 0.000000125;
L = 8;

a=1/(2*R*C)
w0 = 1/sqrt(L*C);


wd = - sqrt(a*a - w0*w0) * j;
s1 = -a + wd * j;
s2 = -a - wd * j;

B1 = 0;
B2 = 98000/(wd);

B2 = floor(B2);
wd = ceil(wd);

V_underdamped =  B2 * exp(-a * t) * sin(wd * t)

%-------------------------------------------------------------
% Plotting The circuit response, mixed and separate
%-------------------------------------------------------------


subplot(2,2,1)
hold on
title('Modelling Natural Response of RLC Circuit')

fplot(V_crticaldamped ,[0,0.01] , 'g')
fplot(V_overdamped * 10 ,[0,0.01] , 'r')
fplot(V_underdamped  ,[0,0.01] )
legend('show','Location','best')

hold off

subplot(2,2,2)
fplot(V_underdamped ,[0,0.1] )
title('Underdamped Response RLC Circuit')
legend('show','Location','best')


subplot(2,2,3)
fplot(V_overdamped ,[0,0.001] , 'r')
title('Overdamped Response RLC Circuit')
legend('show','Location','best')

subplot(2,2,4)
fplot(V_crticaldamped ,[0,0.01] , 'g')
title('Crticial Damped Response RLC Circuit')
legend('show','Location','best')
