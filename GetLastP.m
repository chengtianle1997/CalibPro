function [meanerror,maxerror,errorcounter,errorlabel,p00,p10,p01,p20,p11,p02] = GetLastP(num,u0,v0,fx,fy,bp,k00,k10,k01,k11,k02,WD,b,phi,m)
%[num,txt,raw]=xlsread('TestDistance.xlsx');
size=length(num);   %data rows
x=zeros(size,1);  %x
y=zeros(size,1);  %y
s=zeros(size,1);  %s
%load data
for i = 1:size
    x(i) = num(i,1);
    y(i) = num(i,2);
    s(i) = num(i,3);
end
sc = zeros(size,1);
Fxy=zeros(size,1);
Yy = zeros(size,1);
%Correct data
for i=1:size
     cd = atan ((v0-y(i))/fy);
     angle = (WD*pi)/180+ k00 + k10*cd + k01*x(i) + k11*cd*x(i) + k02*x(i)^2;
      %angle = (WD*pi)/180+ k00 + k10*cd;
     ZE = bp(1)+bp(2)*s(i)*cos(angle)+bp(3)*s(i)*sin(angle);
     sc(i)=(ZE*m+s(i)*b)/(b+ZE);
     Fxy(i) = (b*tan(phi+atan((u0-x(i))/fx))+m)/sc(i);
     Yy(i) = cd;
end
[fitres,goodness, output] = fit([x,Yy],Fxy,'poly22');%,'Robust','LAR');
p00 = fitres.p00;
p10 = fitres.p10;
p01 = fitres.p01;
p20 = fitres.p20;
p11 = fitres.p11;
p02 = fitres.p02;
plot(fitres,[x,Yy],Fxy);
rsquare = goodness.rsquare
errorsc = zeros(size,1);
errorfxy = zeros(size,1);
errors = zeros(size,1);
errorcounter = 0;
maxerror = 0;
%error detection
errorlabel = [];
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
    errors(i) = sp - s(i);
    if abs(errors(i))>5
        errorcounter = errorcounter+1;
        errorlabel(errorcounter) = i;
    end
    if abs(errors(i))>maxerror
        maxerror = abs(errors(i));
    end
end
plot(errorfxy);
plot(errorsc);
plot(errors);
axis([0 size -10 10])
meanerror = mean(abs(errors));
end