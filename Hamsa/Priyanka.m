clear
clc
T = 60.0;
y = 0.4;
A.Ac = 7.11714;
B.Ac = 1210.595;
C.Ac = 229.664;
A.b = 6.87987;
B.b = 1196.760;
C.b = 219.161;
P.Ac = 0.133322*(10^(A.Ac-(B.Ac/(T+C.Ac))));
P.b = 0.133322*(10^(A.b-(B.b/(T+C.b))));
alpha = 0.3864;
beta = 0.2667;
n = 0;
e = 10^(-5);
for x = 0:0.00001:1
    n = n+1;
    y1 = exp(alpha/(1+((alpha*x)/(beta*(1-x))))^2);
    y2 = exp(beta/(1+((beta*(1-x))/(alpha*x)))^2);
    P1 = (x*y1*P.Ac)/y;
    P2 = ((1-x)*y2*P.b)/(1-y);
    if((P2-P1)<e)
        Pressure = P1;
        X = x;
        break
    end
end
format long
n
dew = [X Pressure]