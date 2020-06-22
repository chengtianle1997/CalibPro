bp=[-0.0068 -0.0093 -0.0150];
[num,txt,raw] = xlsread('CameraParam.xlsx');
u0 = num(1);
v0 = num(2);
fx = num(3);
fy = num(4);
WD = num(19);
b = num(5);
phi = num(6);
m = num(7);
k00 = num(8);
k10 = num(9);
k01 = num(10);
k11 = num(11);
k02 = num(12);
p00 = num(13);
p10 = num(14);
p01 = num(15);
p20 = num(16);
p11 = num(17);
p02 = num(18);

[numtest,txttest,rawtest] = xlsread('CalibTest.xlsx');
size = length(numtest);
x=zeros(size,1);  %x
y=zeros(size,1);  %y
s=zeros(size,1);  %s
a = zeros(size,1); %a
for i = 1:size
    x(i) = numtest(i,1);
    y(i) = numtest(i,2);
    s(i) = numtest(i,3);
    a(i) = numtest(i,4);
end
sc = zeros(size,1);
Fxy=zeros(size,1);
Yy = zeros(size,1);
errorsc = zeros(size,1);
errorfxy = zeros(size,1);
errors = zeros(size,1);
errora = zeros(size,1);
maxerrors = 0;
errormax = 5;
errormax_counter = 0;
%error detection
for i = 1:size
    cd = atan ((v0-y(i))/fy);
    fxy = p00 + p10*x(i) + p01*cd + p20*x(i)^2 + p11*x(i)*cd + p02*cd^2;
    %fxy = Fxy(i);
    errorfxy(i) = fxy-Fxy(i);
    scor = (b*tan(phi+atan((u0-x(i))/fx))+m)/fxy;
    errorsc(i) = scor - sc(i);
    %scor = sc(i);
    ap = (WD*pi)/180+ k00 + k10*cd + k01*x(i) + k11*cd*x(i) + k02*x(i)^2;
    %ap = (WD*pi)/180+ k00 + k10*cd;
    sp = (b*scor+(scor-m)*bp(1))/(b+(m-scor)*(bp(2)*cos(ap)+bp(3)*sin(ap)));
    a_self = ap - (WD*pi)/180;
    errors(i) = sp - s(i);
    errora(i) = a_self*180/pi - a(i);
    if abs(errors(i))>errormax
        errormax_counter = errormax_counter+1;
    end
    if errors(i)>maxerrors
        maxerrors = errors(i);
    end
end
plot(errorfxy);
plot(errorsc);
figure(1);
plot(errors);
title('s--error');
figure(2);
plot(errora);
title('a--error');
meanerror_s = mean(abs(errors))
meanerror_a = mean(abs(errora))
errormax_counter
rate = errormax_counter/size
maxerrors