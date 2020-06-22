function[u0,v0,fx,fy,WD] = InputParam()
u0 = zeros(8,1);
v0 = zeros(8,1);
fx = zeros(8,1);
fy = zeros(8,1);
WD = zeros(8,1);
[num,txt,raw] = xlsread('CameraParam.xlsx');
for i = 1:8
   u0(i) = num(1,3*i-2);
   v0(i) = num(2,3*i-2);
   fx(i) = num(3,3*i-2);
   fy(i) = num(4,3*i-2);
   WD(i) = num(19,3*i-2);
end
end