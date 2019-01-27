
P=[1 2 5 10 20 30 40 50 60 70 80 90 100];          %Pressure in bar
T= 273+[-175 -150 -125 -100 -75 -50 -25 0 25 50 75 100 125 150];  %Temperature in Kelvin

Tc=154.6;
Pc=50.46;
R=8.31451e-2;
kappa=0.4069;

syms a(T);

V = volumePengRobinson;
S = zeros(13,14);
b = 0.07780*((R*Tc)/Pc);
for i=1:13                                        %looping over Pressure vector
    for j=1:14                                    %looping over Temperature vector
        Z = (P(i)*V(i,j))/(R*T(j));
        B = (P(i)*b)/(R*T(j));
        a(T) = 0.45724*((R^2*Tc^2)/Pc)*((1+kappa*(1-sqrt(T(j)/Tc)))^2);
        adiff = diff(a);
        Sdiff = R*log(Z-B)+(adiff/2*sqrt(2)*b)*log((Z+(1+sqrt(2))*B)/(Z+(1-sqrt(2))*B));
        S(i,j) = Sdiff+25.46*log(T(j)/298.15)+0.01519*(T(j)-298.15)-0.0000035755*(power(T(j),2)-power(298.15,2))+0.437*power(10,-9)*(power(T(j),3)-power(298.15,3))-R*log(P(i))
    end
end
