% input test cam index
<<<<<<< HEAD
camid = 7;
=======
camid = 1;
>>>>>>> d8176e473c867c79c0086fe774bdd6465b2d1fc7
error_threshold = 2;
%error_threshold = 2.828;
angle_range = 17;
s_range_max = 3000;
s_range_min = 2500;
cre_rate = 0.95;
%filename = "cam8_validation.xlsx";
filename = strcat('cam', string(camid), '_validation.xlsx');

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
% Load data
[num, txt,] = xlsread(filename);
size = length(num);
x = zeros(size, 1);
y = zeros(size, 1);
s = zeros(size, 1);
a = zeros(size, 1);
sp = zeros(size, 1);
ap = zeros(size, 1);
se = zeros(size, 1);
ae = zeros(size, 1);
se_c = zeros(size,1);
error_sum = 0;
error_num = 0;
counter = 0;
for i = 1: size
    x(i) = num(i, 1);
    y(i) = num(i, 2);
    s(i) = num(i, 3);
    a(i) = num(i, 4);
end
% Calculate the predict value
for i = 1: size
    cd = atan ((v0(camid)-y(i))/fy(camid));
    fxy = p00(camid) + p10(camid)*x(i) + p01(camid)*cd + p20(camid)*x(i)^2 + p11(camid)*x(i)*cd + p02(camid)*cd^2;
    scor = (b(camid)*tan(phi(camid)+atan((u0(camid)-x(i))/fx(camid)))+m(camid))/fxy;
    api = (WD(camid)*pi)/180+ k00(camid) + k10(camid)*cd + k01(camid)*x(i) + k11(camid)*cd*x(i) + k02(camid)*x(i)^2;
    ap(i) = k00(camid) + k10(camid)*cd + k01(camid)*x(i) + k11(camid)*cd*x(i) + k02(camid)*x(i)^2;
    sp(i) = (b(camid)*scor+(scor-m(camid))*bp(1))/(b(camid)+(m(camid)-scor)*(bp(2)*cos(api)+bp(3)*sin(api)));
    ap(i) = ap(i)*180/pi;
    se(i) = sp(i) - s(i);
    ae(i) = ap(i) - a(i);
    if(abs(a(i))<angle_range)&&(s(i)<s_range_max)&&(s(i)>s_range_min)
        error_sum = error_sum + abs(se(i));
        %error_sum = error_sum + se(i);
        counter = counter + 1;
        se_c(counter) = abs(se(i)); 
    end
    if (abs(se(i)) > error_threshold)&&(abs(a(i))<angle_range)&&(s(i)<s_range_max)&&(s(i)>s_range_min)
        error_num = error_num + 1;
    end
end
mean_error = error_sum/counter;
%se_c(counter+1:size) = [];
se_cs = sort(se_c(1:counter));
% Write result to xlsx
output_num = zeros(size, 6);
for i = 1: size
    output_num(i, 1) = s(i);
    output_num(i, 2) = a(i);
    output_num(i, 3) = sp(i);
    output_num(i, 4) = ap(i);
    output_num(i, 5) = se(i);
    output_num(i, 6) = ae(i);
%     output_num(i, 4) = a(i);
%     output_num(i, 5) = ap(i);
%     output_num(i, 6) = ae(i);
end
output_file = strcat('cam', string(camid), '_validation_result.xlsx');
B = [{'S_Real', 'Angle', 'S_Pred', 'Angle_Pred', 'S_Error', 'Angle_Error'};num2cell(output_num)];
cre_num = ceil(cre_rate*counter);
<<<<<<< HEAD
H = [{'Mean_Error'}, num2cell(mean_error); {'Samples'}, num2cell(counter);{'Qualified'}, num2cell(counter - error_num);{'Qua_Rate'}, num2cell((counter - error_num)/counter);{'95%_Confidence_Int'}, num2cell(se_cs(cre_num))];
=======
H = [{'Mean_Error'}, num2cell(mean_error); {'Samples'}, num2cell(counter);{'Qualified'}, num2cell(counter - error_num);{'Qua_Rate'}, num2cell((counter - error_num)/counter);{'Confidence_Int'}, num2cell(se_cs(cre_num))];
>>>>>>> d8176e473c867c79c0086fe774bdd6465b2d1fc7
xlswrite(output_file, B);
xlswrite(output_file, H,1,'H2');

