A = 1.7512;
B = 1.2480;
y = 0.4;
p1_sat = 84.4034;
p2_sat = 52.21;
Y = (0:0.004:1);
Y = Y';
P = zeros(753,753);
Q = zeros(753,1);
ga1 = exp(A/(1+((A*y)/(B*(1-y))))^2);
ga2 = exp(B/(1+((B*(1-y))/(A*y)))^2);
p = (1/((y/(ga1*p1_sat))+((1-y)/(ga2*p2_sat))));
for i = 1:3:751
    ga1 = exp(A/(1+((A*Y((i+2)/3,1))/(B*(1-Y((i+2)/3,1)))))^2);
    ga2 = exp(B/(1+((B*(1-Y((i+2)/3,1)))/(A*Y((i+2)/3,1))))^2); 
    P(i:i+2,i:i+2) = [ga1*p1_sat,0,-Y((i+2)/3,1);0,ga2*p2_sat,(Y((i+2)/3,1)-1);1,1,0];
    Q(i+2) = 1;
end
X = P\Q;
Pressure(:,1) = X(3:3:753);
x(:,1) = X(1:3:751);
vle = plot(x,Pressure);
hold on
plot(Y,Pressure)
scatter(y,p,'o')
set(vle,'color',rand(1,3),'linewidth',1);
axis([0 1 50 120])
ylabel('pressure (in KPa)')
xlabel('mole fration')
text(y+0.02,p,['(' num2str(y) ',' num2str(p) ')'])
title('Vapour Liquid Equlibrium at T = 60°C')
legend('x','y','dew point')
hold off