% input test cam index
camid = 1;

bp = [0 0 0];

u0 = zeros(8,1);
v0 = zeros(8,1);
fx = zeros(8,1);
fy = zeros(8,1);
WD = zeros(8,1);
b = zeros(8,1);
phi = zeros(8,1);
m = zeros(8,1);
k00 = zeros(8,1);
k10 = zeros(8,1);
k01 = zeros(8,1);
k11= zeros(8,1);
k02 = zeros(8,1);
p00 = zeros(8,1);
p10 = zeros(8,1);
p01 = zeros(8,1);
p20 = zeros(8,1);
p11 = zeros(8,1);
p02 = zeros(8,1);

% Read the param from CameraParam.xlsx
[u0,v0,fx,fy,WD,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02] = InputAllParam();

% set the test range
x = [400:1:1200];
y = [0:1:2048];
num = length(x);
mum = length(y);
xp = zeros(num * mum,1);
yp = zeros(num * mum,1);
sp = zeros(num * mum,1);
apn = zeros(num * mum,1);
counter = 1;
for i = 1 : mum
    for j = 1 : num
        cd = atan ((v0(camid)-y(i))/fy(camid));
        fxy = p00(camid) + p10(camid)*x(j) + p01(camid)*cd + p20(camid)*x(j)^2 + p11(camid)*x(j)*cd + p02(camid)*cd^2;
        scor = (b(camid)*tan(phi(camid)+atan((u0(camid)-x(j))/fx(camid)))+m(camid))/fxy;
        ap = (WD(camid)*pi)/180+ k00(camid) + k10(camid)*cd + k01(camid)*x(j) + k11(camid)*cd*x(j) + k02(camid)*x(j)^2;
        apn(counter) = (k00(camid) + k10(camid)*cd + k01(camid)*x(j) + k11(camid)*cd*x(j) + k02(camid)*x(j)^2)*180/pi;
        sp(counter) = (b(camid)*scor+(scor-m(camid))*bp(1))/(b(camid)+(m(camid)-scor)*(bp(2)*cos(ap)+bp(3)*sin(ap)));
        xp(counter) = x(j);
        yp(counter) = y(i);
        counter = counter + 1;
    end
end

range = [2500, 2700, 2900, 3100];
range_num =length(range);
min_apn = zeros(range_num,1);
max_apn = zeros(range_num,1);
ap_range = zeros(range_num,1);
for i = 1 : mum * num
    for j = 1 : range_num
        if abs(sp(i) - range(j)) < 40
            if apn(i) > max_apn(j)
                max_apn(j) = apn(i);
            end
            if apn(i) < min_apn(j)
                min_apn(j) = apn(i);
            end
        end
    end
end
for i = 1 : range_num
    range(i)
    min_apn(i)
    max_apn(i)
    ap_range(i) = max_apn(i) - min_apn(i)
end

%axis([,,,,-500,5000]);
%scatter3(xp, yp, sp);
%hold on
%scatter(xp, sp);
%scatter(yp, apn);
%scatter(xp, apn);
%scatter3(xp,yp,apn)

