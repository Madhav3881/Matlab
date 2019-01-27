P = 101.3;
y = 0.548;
A1 = 6.84083;
B1 = 1177.910;
C1 = 220.576;
A2 = 6.87987;
B2 = 1196.760;
C2 = 219.161;
T1 = (B1/(A1-(log10(7.5*P))))-C1;
T2 = (B2/(A2-(log10(7.5*P))))-C2;
a = 0.0951;
b = 0.0911;
delta = 0.01;
n = 0;
for x = 0:0.00001:1
    n = n+1;
    y1 = exp(a/(1+((a*x)/(b*(1-x))))^2);
    y2 = exp(b/(1+((b*(1-x))/(a*x)))^2);
    P1sat = (P*y)/(x*y1);
    P2sat = (P*(1-y))/((1-x)*y2);
    T1calc = (B1/(A1-(log10(7.5*P1sat))))-C1;
    T2calc = (B2/(A2-(log10(7.5*P2sat))))-C2;
    if(abs(T2calc-T1calc)<delta)
        T = T1calc
        X = x
        n
        break
    end
end