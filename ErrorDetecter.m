camid = 7;

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

x_min = 600;
x_max = 1000;

% Read the param from CameraParam.xlsx
[u0,v0,fx,fy,WD,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02] = InputAllParam();
% Test camera degree
y_list = [200 400 600 800 1000 1200 1400 1600 1800];
x_list = zeros(1, size(y_list, 2));
s_list = zeros(2, size(y_list, 2));
a_list = zeros(2, size(y_list, 2));
s_error_list = zeros(1, size(y_list, 2));
a_error_list = zeros(1, size(y_list, 2));
% Param changed
b_add = -0.05;
phi_add = -0.02 * pi / 180;
m_add = 0.02;
% Test Distance
s = 2770;
s_err_allow = 0.1; 
y_counter = 1;

for y = y_list
    % Find a proper x for distance s
    s_pred = 0;
    x_pred = 0;
    x_lo = x_min;
    x_hi = x_max; 
    while abs(s_pred - s) > s_err_allow
        x_mid = (x_lo + x_hi) / 2;
        [s_lo_pred, a] = PredictSA(x_lo, y, camid, u0,v0,fx,fy,WD,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02);
        [s_hi_pred, a] = PredictSA(x_hi, y, camid, u0,v0,fx,fy,WD,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02);
        [s_mid_pred, a] = PredictSA(x_mid, y, camid, u0,v0,fx,fy,WD,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02);
        if (s_lo_pred - s) * (s_mid_pred - s) < 0
            % zero point is in (s_lo, s_mid)
            x_hi = x_mid;
            if abs(s_lo_pred - s) <= abs(s_mid_pred - s)
                x_pred = x_lo;
                s_pred = s_lo_pred;
            else
                x_pred = x_mid;
                s_pred = s_mid_pred;
            end
        elseif (s_hi_pred - s) * (s_mid_pred - s) < 0
            % zero point is in (s_mid, s_hi)
            x_lo = x_mid;
            if abs(s_hi_pred - s) <= abs(s_mid_pred - s)
                x_pred = x_hi;
                s_pred = s_hi_pred;
            else
                x_pred = x_mid;
                s_pred = s_mid_pred;
            end
        else
            break;
        end
    end
    % Calculate the s and a for x_pred
    [s_pred, a_pred] = PredictSA(x_pred, y, camid, u0,v0,fx,fy,WD,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02);
    x_list(y_counter) = x_pred;
    s_list(1, y_counter) = s_pred;
    a_list(1, y_counter) = a_pred;
    y_counter = y_counter + 1;
end

% Change the param
b(camid) = b(camid) + b_add;
phi(camid) = phi(camid) + phi_add;
m(camid) = m(camid) + m_add;
for i = 1:size(y_list, 2)
    [s_pred, a_pred] = PredictSA(x_list(i), y_list(i), camid, u0,v0,fx,fy,WD,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02);
    s_list(2, i) = s_pred;
    a_list(2, i) = a_pred;
    s_error_list(i) = s_pred - s_list(1, i);
    a_error_list(i) = a_pred - a_list(1, i);
end

plot(a_list(1, :), s_error_list);

