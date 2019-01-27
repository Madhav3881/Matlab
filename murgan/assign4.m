function assign4(a)    
    %fid=fopen('prateekquiz4.txt');
    %xvalue=fscanf(fid,'%f');
    % x = load('rupak4.txt');
    % x = x';
    % xvalue = x(:);
    % n=1;
    % for i=1:50
    % for j=1:2
    % y(i,j)=xvalue(n,1);
    % n=n+1;
    % end
    % end
    y = csvread(a);
    xvalue=y(:,1);
    y=y(:,2);
    syms x a b c d
    fn=((1/(2.506*a))*exp((-(((x-b)^2)/(2*a^2)))))+((1/(2.506*c))*exp((-(((x-d)^2)/(2*c^2)))));
    jmat=zeros(50,4);
    param=ones(4,1);
    paramchar=['a','b','c','d'];
    lambda=5;
    k=2;
    ycap=zeros(50,1);
    for i=1:50
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
    sst=sum(y.^2)-(sum(y)*sum(y))/50;
    ssr=sst-sse2;
    sigma=sse2/(50-4);
    covmat=sigma./jtj;
    tcalc=zeros(4,1);
    for i=1:4
    tcalc(i,1)=param(i,1)/sqrt(covmat(i,i))  %a
    end
    paramrange=zeros(4,2);
    for i=1:4
    paramrange(i,1)=param(i,1)+sqrt(covmat(i,i))*abs(tinv(0.025,46)) %b
    paramrange(i,2)=param(i,1)-sqrt(covmat(i,i))*abs(tinv(0.025,46)) %b
    end
    signi=zeros(4,1);
    for i=1:4
    if tcalc(i,1)>tinv(0.025,46) && tcalc(i,1)<tinv(0.975,46)
    signi(i,1)=0;
    else
    signi(i,1)=1;
    end
    end
    ttable(1,1)=tinv(0.025,46);
    ttable(1,2)=tinv(0.975,46);
    p=zeros(4,1);
    for i=1:4
    p(i,1)=1-tcdf(tcalc(i,1),46)   %c
    end
    mssr=ssr/3   %d
    msse=sse2/46  %d
    fstat=mssr/msse;
    ftable=zeros(1,2);
    ftable(1,1)=finv(0.05,3,46);
    ftable(1,2)=finv(0.95,3,46);
    if fstat > ftable(1,1) && fstat < ftable(1,2)
    ftest=0;
    else
    ftest=1;
    end
    rsq=1-(sse2/sst)  %e
    msst=sst/49   %d
    rsqad=1-(msse/msst)   %e
    disp(lambda); %f
end