%Input Param
[u0,v0,fx,fy,WD] = InputParam();
%Laser Plat Param
% bp=[-0.4023 0.0203 -0.0043];
% bp = [-0.0009 0.0132 -0.0138];
bp = [0 0 0];
%register OutParam
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
%Calib Range
minRange = 2400;
maxRange = 3100;
min_angle = -19;
max_angle = 19;
%correct param
p1=1;
p2=0;
%Calib Camera
for i = 7:7
    %test cam i
    %i = 4;
    timescounter = 0; 
    %Read-in the CalibData
    filename = strcat('Cam',string(i),'calib.xlsx');
    [num,txt,] = xlsread(filename);
    %screen out the data
    n = length(num);
    jc = 1;
    numcounter = 1;
    while numcounter<=n
        x = num(jc,1);
        y = num(jc,2);
        s = num(jc,3);
        a = num(jc,4);
        if s>minRange&&s<maxRange&&a>min_angle&&a<max_angle&&x~=0&&y~=0
            %sr = p1*s+p2;
            %num(jc,1)=x;
            %num(jc,2)=y;
            sr = s;
            num(jc,3)= sr;
            num(jc,4)=a;
            jc = jc+1;
         else
             num(jc,:)=[];
        end
        numcounter = numcounter+1;
    end
    errorcounter = inf;
    while errorcounter>0
        %Get Degree Fit
        [k00(i),k10(i),k01(i),k11(i),k02(i)] = GetDegreeParam(num,v0(i),fy(i));
        %Get b phi m
        [b(i),phi(i),m(i)] = GetBPM(num,u0(i),v0(i),fx(i),fy(i),bp,k00(i),k10(i),k01(i),k11(i),k02(i),WD(i));
        %Get the fit for denominator
        [meanerror,maxerror,errorcounter,errorlabel,p00(i),p10(i),p01(i),p20(i),p11(i),p02(i)] = GetLastP(num,u0(i),v0(i),fx(i),fy(i),bp,k00(i),k10(i),k01(i),k11(i),k02(i),WD(i),b(i),phi(i),m(i));
        %Cope with the error
        jr = errorcounter;
        while jr>0
            num(errorlabel(jr),:) = [];
            jr = jr-1;
        end
        if timescounter>8
            break;
        end
    end
end
%Output Param
OutPutParam(u0,v0,fx,fy,b,phi,m,k00,k10,k01,k11,k02,p00,p10,p01,p20,p11,p02,WD);