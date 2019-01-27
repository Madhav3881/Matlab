clear
clc
Y = 0.4;
P.Ac = 84.4034;
P.Me = 52.21;
alpha = 2.5506;
beta = 1.0989;
n = 0;
e = 10^(-5);
px = zeros(200,2);
py = zeros(200,2);
for y = 0.005:0.005:1
    for x = 0:0.001:1
        n = n+1;
        g1 = exp(alpha/(1+((alpha*x)/(beta*(1-x))))^2);
        g2 = exp(beta/(1+((beta*(1-x))/(alpha*x)))^2);
        P1 = (x*g1*P.Ac)/y;
        P2 = ((1-x)*g2*P.Me)/(1-y);
        if((P2-P1)<e)
            p = P1;
            if(Y == y)
                N = n;
                X = x;
                Pressure = P1;
            end
            break
        end
    end
    i = round(y*200);
    px(i,:) = [p x];
    py(i,:) = [p y];
end
plot(px(:,2),px(:,1),'r',py(:,2),py(:,1),'b')
N;
dew = [X Pressure];