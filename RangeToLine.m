[num,txt,raw] = xlsread('convert.xlsx');
x = zeros(2048,1);
y = zeros(2048,1);
s = zeros(2048,1);
a = zeros(2048,1);
st = zeros(2048,1);
max = 3900;
min = 2200;
res = 9999999;
counter = 0;
for i = 1200:1600
   s(i) = num(2*i-1);
   a(i) = num(2*i);
%    if s(i)<max &&s(i)>min
%        counter = counter+1;
%        st(counter) = s(i);
%        if s(i)<res
%         res = s(i);
%        end
%    end
   if s(i)>min && s(i)<max
    counter = counter+1;
    x(counter) = s(i)*cos(a(i));
    y(counter) = s(i)*sin(a(i));
   end
end
x(find(x==0))=[];
y(find(y==0))=[];
Line = fittype(@(k,b,x) k*x+b);
[fitres,goodness,output] = fit(x,y,Line);
plot(fitres,x,y);
k = fitres.k;
b = fitres.b;
goodness.rsquare
dis = abs(b)/sqrt(k*k+1)

