function g(x)
    A = csvread(x);
    xdata = A(:,1);
    ydata = A(:,2);
    x0 = [1,1,1,1];
    f = @(x,xdata)((1/sqrt(2*pi)*x(1))*exp(-((xdata-x(2)).^2/(2*x(1)^2))))+((1/sqrt(2*pi)*x(3))*exp(-((xdata-x(4)).^2/(2*x(3)^2))));
    opts = optimset('Algorithm', 'levenberg-marquardt');
    [parameters,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(f,x0,xdata,ydata,[],[],opts)
    lambdau = lambda.upper
    lambdal = lambda.lower
end