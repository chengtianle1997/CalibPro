% n = length(y);
% cd = zeros(n,1);
% ar = zeros(n,1);
% ap = zeros(n,1);
% era = zeros(n,1); 
% v0 = 1046.7;
% fy = 2494.6;
% for i = 1:n
%    cd(i) = atan ((v0-y(i))/fy);
%    ar(i) = 0.5*a(i)*pi/180;
% end
% % for i = 1:n
% %     ap(i) = (fittedmodely.k1*s(i)^2+fittedmodely.k2*s(i)+fittedmodely.k3)*cd(i) + fittedmodely.k4*s(i)^2+fittedmodely.k5*s(i)+fittedmodely.k6;
% %     era(i) = ap(i) - ar(i);
% % end
% for i = 1:n
%     ap(i) = fittedmodely.p00 + fittedmodely.p10*cd(i) + fittedmodely.p01*s(i) + fittedmodely.p11*cd(i)*s(i) + fittedmodely.p02*s(i)^2;
%     era(i) = ap(i) - ar(i);
% end
% error = mean(abs(era(:)))
%Cam2
u0 = 1320.7;
v0 = 1046.7;
fx = 2499.3;
fy = 2494.6;
WD = 77;
%Cam3
% u0 = 1353.2;
% v0 = 1085.4;
% fx = 2524.8;
% fy = 2521.7;
% WD = 118;
bp = [0.0121,-0.0248,0.0147];
[k00,k10,k01,k11,k02] = GetDegreeParam(v0,fy);
% k00 = -0.00681;
%  k10 = 0.8385;
[b,phi,m] = GetBPM(u0,v0,fx,fy,bp,k00,k10,k01,k11,k02,WD);
[meanerror,p00,p10,p01,p20,p11,p02] = GetLastP(u0,v0,fx,fy,bp,k00,k10,k01,k11,k02,WD,b,phi,m)
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

