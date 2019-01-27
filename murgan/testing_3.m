function testing_3(m)
    data = csvread(m);
    xvalue = data(:,1);
    y = data(:,2);
    syms x a b c d
    fn=1/(sqrt(2*pi)*a)*exp(-(((x-b)^2)/(2*a^2)))+1/(sqrt((2*pi)*c))*exp(-(((x-d)^2)/(2*c^2)));
    jmat=zeros(50,4);
    param=ones(4,1);
    paramchar=['a','b','c','d'];
    lambda=5;
    k=2;

    ycap = zeros(50,1);

    for i = 1:50
        ycap(i,1)=(subs(fn,[x,a,b,c,d],[xvalue(i,1),param(1,1),param(2,1),param(3,1),param(4,1)]));
    end

    sse1=double(sum((ycap-y).^2));
    sse2=0;
    n=1;
    while n<=100
        for i=1:50
            for j=1:4
                jmat(i,j)=double(subs(diff(fn,paramchar(1,j)),[x,a,b,c,d],[xvalue(i,1),param(1,1),param(2,1),param(3,1),param(4,1)]));
            end
        end
        jtj=(jmat.')*jmat;
        jtjmi=jtj+lambda*diag(diag(jtj));
        param= param + (inv(jtjmi)*((jmat.')*(ycap-y)));
        for i=1:50
            ycap(i,1)=double(subs(fn,[x,a,b,c,d],[xvalue(i,1),param(1,1),param(2,1),param(3,1),param(4,1)]));
        end
        sse2=double(sum((ycap-y).^2));
        if(abs(sse2-sse1)<10^-8)
            break;
        elseif(sse1<sse2)
            lambda=lambda*k;
        elseif(sse1>sse2)
            lambda=lambda/k;
        else
        end
        sse1=sse2;
        n=n+1;
    end
    fprintf("final lambda value: %f\n", lambda);
    fprintf("no of iterations: %d\n", n);
    fprintf("The population estimates are: %f %f %f %f\n", param(1), param(2), param(3), param(4));
    s = sse2/(50-4);
    covmat = inv(jtj);

    for i=1:4
        cilow = param(i) - abs(tinv(0.05/2,46))*s*sqrt(covmat(i,i));
        cihigh = param(i) + abs(tinv(0.05/2,46))*s*sqrt(covmat(i,i));
        fprintf("95 percent CI: (%f , %f)\n", cilow, cihigh);
        t = param(i)/(s*sqrt(covmat(i,i)));
        p = 2*(1-tcdf(abs(t),46));
        fprintf("t value: %f\n", t);
        fprintf("p value: %f\n", p);
        if p < 0.05
            fprintf("The population value b%d is different from zero\n", i-1);
        else
            fprintf("The population value b%d is not different from zero\n", i-1);
        end
    end

    ybar = mean(y);
    sst = 0;
    for i = 1:50
        sst = sst + (y(i)-ybar)^2;
    end
    ssr = sst-sse2;
    mssr=ssr/3;
    msse=sse2/46;
    R2 = 1-(sse2/sst);
    msst = sst/49;
    R2adj = 1-(msse/msst);

    fprintf("MSE = %f\n",msse);
    fprintf("MSR = %f\n",mssr);
    fprintf("SST = %f\n",sst);
    fprintf("R2 = %f\n", R2);
    fprintf("R2adj = %f\n", R2adj);
end