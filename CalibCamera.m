%Instructions:
% @1 Input the measured Angle data to 'TestAngle.xlsx' in column order 'x' 'y' 's' 'a' 
% @2 Input the measured Distance data to 'TestDistance.xlse' in the same order above 
% @3 Input the Internal param and WorldDegree below in demo
% @p.s. You can just comment or uncomment param for convinience



%Cam1
% u0 = 1322.4;
% v0 = 1045.8;
% fx = 2471.4;
% fy = 2464.9;
% WD = 34.85;
%Cam2
% u0 = 1312.4;
% v0 = 1005.8;
% fx = 2480.1;
% fy = 2474.3;
% WD = 75.425;
%Cam3
u0 = 1299.9;
v0 = 1022.4;
fx = 2475.1;
fy = 2468.3;
WD = 116.625;
% Cam4
% u0 = 1301.7;
% v0 = 1015.7;
% fx = 2468.5;
% fy = 2463.0;
% WD = 157.625;
% Cam5
% u0 = 1286.0;
% v0 = 1010.0;
% fx = 2493.8;
% fy = 2487.0;
% WD = 198.625;
%Cam6
% u0 = 1251.1;
% v0 = 1014.3;
% fx = 2493.4;
% fy = 2486.6;
% WD = 239.625;
% Cam7
% u0=1326.7;
% v0=1054.5;
% fx=2462.4;
% fy=2456.3;
% WD=280.125;
% 
% % Cam8
% u0 = 1322.5;
% v0 = 1015.5;
% fx = 2475.9;
% fy = 2473.3;
% WD = 321.175;

%Param for Laser Platform
%bp = [0.0121,-0.0248,0.0147];
bp=[-0.4023 0.0203 -0.0043];
%Get Degree Fit
[k00,k10,k01,k11,k02] = GetDegreeParam(v0,fy);
% k00 = -0.00681;
%  k10 = 0.8385;
%Get b phi m
[b,phi,m] = GetBPM(u0,v0,fx,fy,bp,k00,k10,k01,k11,k02,WD);
%Get the fit for denominator
[meanerror,meanerrorin,maxerror,maxerrorin,errorcounter,p00,p10,p01,p20,p11,p02] = GetLastP(u0,v0,fx,fy,bp,k00,k10,k01,k11,k02,WD,b,phi,m)
%Output All External params
b
phi
m
k00
k10
k01
k11
k02
p00
p10
p01
p20
p11
p02
meanerror
meanerrorin
maxerror
maxerrorin
errorcounter
OutPutParam(u0,v0,fx,fy,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02,WD);