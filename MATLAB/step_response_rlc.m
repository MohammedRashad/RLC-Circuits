% Electric Circuits II - RLC Parallel Circuit Step Response 
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

C = 0.000000025;
L = 0.025;
w0 = 1/sqrt(L*C);

%-------------------------------------------------------------
%Solve for overdamped response
%-------------------------------------------------------------

R = 400;
a = 1/(2*R*C);
wd = sqrt(a*a - w0*w0);
s1 = -a + wd;
s2 = -a - wd;

eqn1 = 24 + a1 + a2 == 0;
eqn2 = s1 * a1 + s2 * a2 == 0;
 
sol = solve([eqn1, eqn2], [a1 , a2 ]);
A1 = sol.a1;
A2 = sol.a2;

I_overdamped = 24 + A1 * exp((s1 * t)) + A2 * exp((s2 * t))

%------------------------------------------------------------
% Solve for crtitcally damped response
%-------------------------------------------------------------

R = 500;
a = 1/(2*R*C);
wd = sqrt(a*a - w0*w0);
s1 = -a + wd;
s2 = -a - wd;

eqn1 = 24 + d2;
eqn2 = d1 - a * d2;
 
sol = solve([eqn1, eqn2], [d1 , d2]);
D1 = sol.d1;
D2 = sol.d2;


I_crticaldamped = 24 + D1 * t * exp((-a * t)) + D2 * exp((-a * t))


%-------------------------------------------------------------
% Solve for underdamped response
%-------------------------------------------------------------


R = 625;
a = 1/(2*R*C);
wd = - sqrt(a*a - w0*w0) * j;
s1 = -a + wd * j;
s2 = -a - wd * j;

eqn1 = 24 + b1 == 0;
eqn2 = (wd) * b2 - a * b1 == 0;
 
sol = solve([eqn1, eqn2], [b1 , b2 ]);
B1 = sol.b1;
B2 = sol.b2;

I_underdamped = 24 + B1 * exp((-a * t)) * cos(wd * t) +  B2 * exp((-a * t )) * sin(wd * t)





%-------------------------------------------------------------
% Plotting The circuit response, mixed and separate
%-------------------------------------------------------------


subplot(2,2,1)
hold on
title('Modelling Step Response of RLC Circuit')

fplot(I_underdamped ,[0,0.001] )
fplot(I_overdamped , [0 0.001] )
fplot(I_crticaldamped , [0 0.001])
legend('show','Location','best')

hold off

subplot(2,2,2)
fplot(I_underdamped ,[0,0.001] )
title('Underdamped Response RLC Circuit')
legend('show','Location','best')


subplot(2,2,3)
fplot(I_crticaldamped ,[0,0.001] , 'r')
title('Overdamped Response RLC Circuit')
legend('show','Location','best')

subplot(2,2,4)
fplot(I_overdamped ,[0,0.001] , 'g')
title('Crticial Damped Response RLC Circuit')
legend('show','Location','best')
