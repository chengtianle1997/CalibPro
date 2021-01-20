function [s, a] = PredictSA(x, y, camid, u0,v0,fx,fy,WD,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02)
% Predict s and a using x, y and other model params
bp = [0 0 0];
cd = atan ((v0(camid)-y)/fy(camid));
fxy = p00(camid) + p10(camid)*x + p01(camid)*cd + p20(camid)*x^2 + p11(camid)*x*cd + p02(camid)*cd^2;
scor = (b(camid)*tan(phi(camid)+atan((u0(camid)-x)/fx(camid)))+m(camid))/fxy;
api = (WD(camid)*pi)/180+ k00(camid) + k10(camid)*cd + k01(camid)*x + k11(camid)*cd*x + k02(camid)*x^2;
a = k00(camid) + k10(camid)*cd + k01(camid)*x + k11(camid)*cd*x + k02(camid)*x^2;
s = (b(camid)*scor+(scor-m(camid))*bp(1))/(b(camid)+(m(camid)-scor)*(bp(2)*cos(api)+bp(3)*sin(api)));
a = a * 180 / pi;
end

