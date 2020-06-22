P = [[5.1613 0 1.2887];[5.1611 0 1.2773];[5.1612 0 1.2394];[5.1616 0 1.1961];[5.1611 0 1.163];[5.1614 0 1.1591];[5.1614 0 1.1887];[5.1612 0 1.2336]];%�궨��
a = [0 41.547 82.123 123.317 164.245 205.447 245.825 287.423]+38.383;%�궨���Ӧ����
Ori = [1.7193 0 1.2238];%ԭ��

n = length(P);
Po = zeros(n,3);
Pt = zeros(n,3);
%תΪ������
for i = 1:n
    a(i) = a(i)*pi/180;
end
%ת��Ϊ�����ԭ�������
for i=1:n
    Po(i,:) = P(i,:)-Ori;
end
%��ת����
for i=1:n
    %˳ʱ����תa
    TransA=[cos(-a(i)),-sin(-a(i));sin(-a(i)),cos(-a(i))];
    Pt(i,1:2) = TransA*Po(i,1:2)';
    Pt(i,3) = Po(i,3);
end
x = zeros(1,n);
y = zeros(1,n);
z = zeros(1,n);
%���ƽ��
for i = 1:n
    x(i) = Pt(i,1);
    y(i) = Pt(i,2);
    z(i) = Pt(i,3);
end
x = x';
y = y';
z = z';
scatter3(x,y,z,'filled')
hold on
X=[ones(n,1) x y];
b=regress(z,X)

xfit = min(x):0.1:max(x);
yfit = min(y):0.1:max(y);
[xfit,yfit]=meshgrid(xfit,yfit);
zfit = b(1)+b(2)*xfit+b(3)*yfit;
mesh(xfit,yfit,zfit);



