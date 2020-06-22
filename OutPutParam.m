function [] =  OutPutParam(u0,v0,fx,fy,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02,WD)
for i = 1:8
    Nums = {u0(i),v0(i),fx(i),fy(i),b(i),phi(i),m(i),k00(i),k10(i),k01(i),k11(i),k02(i),p00(i),p10(i),p01(i),p20(i),p11(i),p02(i),WD(i)};
    posloc = strcat(char(64+3*i-1),'2');
    Nums = Nums';
    xlswrite('CameraParam.xlsx',Nums,1,posloc);
end
end 