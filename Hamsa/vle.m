function V = vle(y)
    P = zeros(202,1);
    p1 = 114.114;
    p2 = 84.4;
    alpha = 0.6184;
    beta = 0.5797;
    X = zeros(202,2);
    X(2:201,1) = rand(200,1);
    X(:,1) = sort(X(:,1),'ascend');
    X(202,1) = 1;
    X(:,2) = 1-X(:,1);
    Y = zeros(202,2);
    g1 = exp(alpha/(1+((alpha*y)/(beta*(1-y))))^2);
    g2 = exp(beta/(1+((beta*(1-y))/(alpha*y)))^2);
    p = (1/((y/(g1*p1))+((1-y)/(g2*p2))));
    for i = 1:202
        g1 = exp(alpha/(1+((alpha*X(i,1))/(beta*X(i,2))))^2);
        g2 = exp(beta/(1+((beta*X(i,2))/(alpha*X(i,1))))^2);
        P(i,1) = (X(i,1)*g1*p1)+(X(i,2)*g2*p2);
        Y(i,1) = 1-((X(i,2)*g2*p2)/P(i,1));
        Y(i,2) = 1-Y(i,1);
    end
    V = plot(X(:,1),P);
    hold on
    plot(Y(:,1),P)
    set(V,'color',rand(1,3),'linewidth',1);
    axis([0 1 80 130])
    ylabel('pressure in KPa')
    xlabel('x1,y1')
    text(y,p-0.2,['\leftarrow dew point (' num2str(y) ',' num2str(p) ')'])
    legend('x1','y1')
    title('Vapour liquid equlibrium for Acetone-Methanol at T = 60�C')
    hold off
end