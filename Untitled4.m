x=
y= 
cd = atan ((v0-y)/fy);
fxy = p00 + p10*x + p01*cd + p20*x^2 + p11*x*cd + p02*cd^2;
scor = (b*tan(phi+atan((u0-x)/fx))+m)/fxy;
ap = (WD*pi)/180+ k00 + k10*cd + k01*x + k11*cd*x + k02*x^2;
sp = (b*scor+(scor-m)*bp(1))/(b+(m-scor)*(bp(2)*cos(ap)+bp(3)*sin(ap)));
