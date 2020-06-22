function [] =  CorrectXY(u0,v0,fx,fy,k1,k2,p1,p2)

[num,txt,raw]=xlsread('TestAngle.xlsx');
n = length(num);
x = zeros(n,1);
y = zeros(n,1);
xc = zeros(n,1);
yc = zeros(n,1);
s = zeros(n,1);
a = zeros(n,1);
newnum = zeros(n,4);
for i = 1:n
    x(i) = num(i,1);
    y(i) = num(i,2);
    s(i) = num(i,3);
    a(i) = num(i,4);
    xr = (x(i)-u0)/fx;
    yr = (y(i)-v0)/fy;
    rsqrt = xr^2 + yr^2;
    rsqrts = rsqrt^2;
    %RadialCorrection
    xc(i) = u0 + (xr*(1+k1*rsqrt+k2*rsqrts))*fx;
    yc(i) = v0 + (yr*(1+k1*rsqrt+k2*rsqrts))*fy;
    %TangentialCorrection
    xr = (xc(i)-u0)/fx;
    yr = (yc(i)-v0)/fy;
    rsqrt = xr^2 + yr^2;
    xc(i) = (xr + 2 * p1*xr*yr + p2 * (rsqrt + 2 * xr*xr))*fx + u0;
    yc(i) = (yr + p1*(rsqrt + 2 * yr*yr) + 2 *p2*xr*yr)*fy + v0;
    newnum(i,1) = xc(i);
    newnum(i,2) = yc(i);
    newnum(i,3) = s(i);
    newnum(i,4) = a(i);
end
xlswrite('TestAngle.xlsx',newnum,'Sheet2')
[num,txt,raw]=xlsread('TestDistance.xlsx');
n = length(num);
x = zeros(n,1);
y = zeros(n,1);
xc = zeros(n,1);
yc = zeros(n,1);
s = zeros(n,1);
a = zeros(n,1);
newnum = zeros(n,3);
for i = 1:n
    x(i) = num(i,1);
    y(i) = num(i,2);
    s(i) = num(i,3);
    %a(i) = num(i,4);
    xr = (x(i)-u0)/fx;
    yr = (y(i)-v0)/fy;
    rsqrt = xr^2 + yr^2;
    rsqrts = rsqrt^2;
    %RadialCorrection
    xc(i) = u0 + (xr*(1+k1*rsqrt+k2*rsqrts))*fx;
    yc(i) = v0 + (yr*(1+k1*rsqrt+k2*rsqrts))*fy;
    %TangentialCorrection
    xr = (xc(i)-u0)/fx;
    yr = (yc(i)-v0)/fy;
    rsqrt = xr^2 + yr^2;
    xc(i) = (xr + 2 * p1*xr*yr + p2 * (rsqrt + 2 * xr*xr))*fx + u0;
    yc(i) = (yr + p1*(rsqrt + 2 * yr*yr) + 2 *p2*xr*yr)*fy + v0;
    newnum(i,1) = xc(i);
    newnum(i,2) = yc(i);
    newnum(i,3) = s(i);
    %newnum(i,4) = a(i);
end
xlswrite('TestDistance.xlsx',newnum,'Sheet2')
end