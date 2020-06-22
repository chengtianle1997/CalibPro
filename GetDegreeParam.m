function [k00,k10,k01,k11,k02] = GetDegreeParam(num,v0,fy)
% [num,txt,raw]=xlsread('TestDistance.xlsx');
n = length(num);
x = zeros(n,1);
y = zeros(n,1);
s = zeros(n,1);
a = zeros(n,1);
cd = zeros(n,1);
ar = zeros(n,1);
ap = zeros(n,1);
era = zeros(n,1); 
%get data from file
for i = 1:n
    x(i) = num(i,1);
    y(i) = num(i,2);
    s(i) = num(i,3);
    a(i) = num(i,4);
    cd(i) = atan ((v0-y(i))/fy);
    ar(i) = a(i)*pi/180;
end
%DegreeFunction = fittype(@(k00,k10,k01,k11,k02,x,y) k00+k10*x+k01*y+k11*x*y+k02*y^2);
[fittedmodely,goodness, output] = fit([cd,x],ar,'poly12','Robust','LAR');
for i = 1:n
    ap(i) = fittedmodely.p00 + fittedmodely.p10*cd(i) + fittedmodely.p01*x(i) + fittedmodely.p11*cd(i)*x(i) + fittedmodely.p02*x(i)^2;
    era(i) = ap(i) - ar(i);
end
sse = goodness.sse
rsquare = goodness.rsquare
meanerror = mean(abs(era(:)))
plot(abs(era));
k00 = fittedmodely.p00;
k10 = fittedmodely.p10;
k01 = fittedmodely.p01;
k11 = fittedmodely.p11;
k02 = fittedmodely.p02;
end