function eq = equlibrium(y1)
    p1 = 114.114;
    p2 = 52.21;
    P = zeros(201,1);
    a12 = 0.405;
    a21 = 0.405;
    y(:,1) = (0:200);
    y = y/200;
    x = zeros(201,1);
    gamma1 = exp(a12/(1+((a12*y1)/(a21*(1-y1))))^2);
    gamma2 = exp(a21/(1+((a21*(1-y1))/(a12*y1)))^2);
    A = [gamma1*p1,0,-y1;0,gamma2*p2,(y1-1);1,1,0];
    B = [0;0;1];
    X = A\B;
    p = X(3);
    for i = 1:201
        gamma1 = exp(a12/(1+((a12*y(i,1))/(a21*(1-y(i,1)))))^2);
        gamma2 = exp(a21/(1+((a21*(1-y(i,1)))/(a12*y(i,1))))^2);
        A = [gamma1*p1,0,-y(i,1);0,gamma2*p2,(y(i,1)-1);1,1,0];
        B = [0;0;1];
        X = A\B;
        x(i,1) = X(1);
        P(i,1) = X(3);
    end
    eq = plot(x,P);
    hold on
    plot(y,P)
    plot([y1;y1],[0;p],'--')
    plot([0;y1],[p;p],'--')
    set(eq,'color',rand(1,3),'linewidth',1);
    axis([0 1 45 140])
    ylabel('pressure in KPa')
    xlabel('x,y')
    text(y1+0.02,p,['(' num2str(y1) ',' num2str(p) ') dew point'])
    title('VLE for Acetone and Benzene at T = 60°C')
    legend('x','y','y1','Pressure')
    hold off
end