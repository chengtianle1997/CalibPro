function [b,phi,m] = GetBPM(num,u0,v0,fx,fy,bp,k00,k10,k01,k11,k02,WD)
%[num,txt,raw]=xlsread('TestDistance.xlsx');
size=length(num);   %data rows
time = 5;  %iteration times
x=zeros(size,1);  %x
y=zeros(size,1);  %y
s=zeros(size,1);  %s
bt = 0;
phit = 0;
mt = 0;
%load data
for i = 1:size
    x(i) = num(i,1);
    y(i) = num(i,2);
    s(i) = num(i,3);
end
%choose data on v0
xc=zeros(size,1);
yc=zeros(size,1);
sc=zeros(size,1);
count = 0;
for i = 1:size
    if(abs(y(i)-v0)<2)
        count = count + 1;
        xc(count) = x(i);
        yc(count) = y(i);
        sc(count) = s(i);
    end
end
% for i = count+1:size
%     xc(i) = [];
%     yc(i) = [];
%     sc(i) = [];
% end
xc(count+1:size) = [];
yc(count+1:size) = [];
sc(count+1:size) = [];
scor = sc;
ZE = zeros(count,1);
%start iteration
for t = 1:time
    %fit b,phi,m
    DisFunction = fittype(@(bf,phif,mf,x) bf*tan(phif+atan((u0-x)/fx))+mf);
    [fitres,goodness, output] = fit(xc,scor,DisFunction,'Lower',[260,1.0,100],'Upper',[550,1.35,800]);
    bt = fitres.bf;
    phit = fitres.phif;
    mt = fitres.mf;
    goodness.rsquare
    plot(fitres,xc,scor);
    %¼ÆËãZE
    for i=1:count
        cd = atan ((v0-yc(i))/fy);
        angle = (WD*pi)/180+ k00 + k10*cd + k01*xc(i) + k11*cd*xc(i) + k02*xc(i)^2;
        %angle = (WD*pi)/180+ k00 + k10*cd;
        ZE(i)=bp(1)+bp(2)*sc(i)*cos(angle)+bp(3)*sc(i)*sin(angle);
        scor(i)=(sc(i)*bt+ZE(i)*mt)/(bt+ZE(i));
    end
end
b = bt;
m = mt;
phi = phit;
end