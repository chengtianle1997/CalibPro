u0 = 1353.2;
v0 = 1085.4;
fx = 2524.8;
fy = 2521.7;
WD = 118;
[num,txt,raw]=xlsread('TestAngle.xlsx');
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