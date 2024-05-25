clear;clc;
s = tf('s');
p1 = 0.019;
p2 = 0.021;
p3 = 10.19*10^(-6);
n = 0.177;
V = 120;
Ag = 0.8;
tgmax = 40;
Xb = 0.0054;
Gb = 80;
%functia de tf a procesului (cu aproximari)
sys_proces = (-0.075)/((5.65*s+1)*(47.62*s+1)*(40.99*s+1));
[num_proces, den_proces] = tfdata(sys_proces);
num_proces = cell2mat(num_proces);
den_proces = cell2mat(den_proces);


%calcule regulator cu plasare poli
pol1 = [1 2*0.05 0.05^2];
pol2 = [1 0.5];
calc = conv(pol1 , pol2);
rootss = roots([0.0525 -0.6 1]);


Kr = -0.33; Tf1 = 2.0257; Tf2 = 9.4028;
num_pp = (5.65*s+1)*(47.62*s+1)*(40.99*s+1);
den_pp = s*(7.0426*s+1)*(1.5106*s+1);
sys_pp = num_pp/den_pp;
[num_pp, den_pp] = tfdata(sys_pp);
%num si den ptr regulator plasare poli
num_pp = cell2mat(num_pp);
den_pp = cell2mat(den_pp);


G0 = feedback(sys_pp*sys_proces, 1);
[num, den] = tfdata(G0);
num = cell2mat(num);den = cell2mat(den);


%regulator CMVK
Kr_cmvk = -1.18;
sys_cmvk = ((47.62*s+1)*(40.99*s+1))/(s*(0.565*s+1));
[num_cmvk, den_cmvk] = tfdata(sys_cmvk);
num_cmvk = cell2mat(num_cmvk);
den_cmvk = cell2mat(den_cmvk);

%regulator plasare poli - ajustari
%Kr = -0.33; Tf1 = 7.0426; Tf2 = 1.5106;
Kr1 = -0.0001;
TF2 = 4.389; TF1 = 0.761;
num1 = (5.65*s+1)*(47.62*s+1)*(40.99*s+1);
den1 = s*(TF1*s+1)*(TF2*s+1);
sys_ajust = num1 / den1;
[num1, den1] = tfdata(sys_ajust);
num1 = cell2mat(num1); den1 = cell2mat(den1);

%regulator CMVK - ajustari
Kr2 = -0.0001;
num2 = num_cmvk;
den2 = den_cmvk;