clear;clc;
p1 = 0.019;
p2 = 0.021;
p3 = 10.19*10^(-6);
n = 0.177;
V = 120;
Ag = 0.8;
tgmax = 40;
Xb = 0.0054;
Gb = 80;
%regulatorul de stare
%controlabilitate
A = [-(p1+Xb) -Gb 0;
    0 -p2 p3;
    0 0 -n];
B = [0;
    0;
    1/V];
C = [1 0 0];

P = [B A*B A^2*B];
rankP = rank(P);
detP = det(P);

%polinom caracteristic
syms k1 k2 k3 s
A = [-(p1+Xb) Gb 0; 0 p2 -p3; 0 0 n];
B = [0; 0; 1/V];
K = [k1 k2 k3];
Cs1 = vpa(s*eye(3)-A+B*K);
Cs2 = det(Cs1);

p1 = -0.02;
p2 = -0.02;
p3 = -0.2;


K3 = 49.63398536;
K2 = 3449.8976;
K1 = -30.68112952;
Kn = [K1 K2 K3];

%estimatorul de stare;
Ke = [k1; k2; k3];

%observabilitate
Q = [C;C*A;C*A^2];
detQ = det(Q);
rangQ = rank(Q);

%calculare determinant pentru C(s)
Cs2 = vpa(s*eye(3)-A+Ke*C);
Cs3 = det(Cs2);

%vectorul estimator de stare
Ke1 = 0.4136;
Ke2 = 0.0010376275;
Ke3 = 0.8481371443;
Ken = [Ke1; Ke2; Ke3];


%factorul de prefiltrare
Kr = 1/(C*inv(B*Kn-A)*B);