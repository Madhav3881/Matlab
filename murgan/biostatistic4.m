%function biostatistic4(m)
    A = csvread(m);
    xvalue = A(:,1);
    yvalue = A(:,2);
    
    % x1=[-5 -4.7 -4.4 -4.1 -3.8 -3.5 -3.2 -2.9 -2.6 -2.3 -2 -1.7 -1.4 -1.1 -0.8 -0.5 -0.2 0.1 0.4 0.7 1 1.3 1.6 1.9 2.2 2.5 2.8 3.1 3.4 3.7 4 4.3 4.6 4.9 5.2 5.5 5.8 6.1 6.4 6.7 7 7.3 7.6 7.9 8.2 8.5 8.8 9.1 9.4 9.7];
    % yvalue=[0.0627 0.044004 -0.10589 0.046913 -0.017169 -0.039123 0.01192 0.047261 0.050477 -0.019576 0.10912 0.049505 0.071722 0.1023 0.19384 0.17377 0.30005 0.23323 0.298 0.35875 0.29332 0.32931 0.35713 0.26704 0.27815 0.14595 0.15683 0.098582 0.061085 -0.03161 0.056457 0.070765 0.11667 0.26328 0.21086 0.32656 0.47706 0.37024 0.35516 0.26548 0.29502 0.13784 0.14202 0.044966 0.0067842 0.0041762 0.024821 0.017537 0.013385 0.031153]; 
    % xvalue=x1';
    % yvalue=yvalue';
    
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
    %sse1=double(sum((ycap-yvalue).^2));
    sse2=0;
    n=0;


    for i=1:50
            for j=1:4
                jmat(i,j)=double(subs(diff(fn,paramchar(1,j)),[x,a,b,c,d],[xvalue(i,1),param(1,1),param(2,1),param(3,1),param(4,1)]));
            end
    end
        jtj=(jmat.')*jmat;
        jtjmi=jtj+lambda*diag(diag(jtj));
        param1= param + (inv(jtjmi)*((jmat.')*(ycap-yvalue)));
    %     for i=1:50
    %         ycap(i,1)=double(subs(fn,[x,a,b,c,d],[xvalue(i,1),param(1,1),param(2,1),param(3,1),param(4,1)]));
    %     end
    %     sse=double(sum((ycap-yvalue).^2));


    %initial
    for i=1:50
            summ=0;
            for j=1:4
                summ=summ+jmat(i,j)*(param1(j,1)-param(j,1));
            end
            z(i)=((ycap(i)-yvalue(i))-(summ))^2;
    end

    chi=sum(z);

    chi_new=0;

    param = param1;
    while n<=100
        for i=1:50
            for j=1:4
                jmat(i,j)=double(subs(diff(fn,paramchar(1,j)),[x,a,b,c,d],[xvalue(i,1),param(1,1),param(2,1),param(3,1),param(4,1)]));
            end
        end
        jtj=(jmat.')*jmat;
        jtjmi=jtj+lambda*diag(diag(jtj));
        param1= param + (inv(jtjmi)*((jmat.')*(ycap-yvalue)));

        for i=1:50
            ycap(i,1)=double(subs(fn,[x,a,b,c,d],[xvalue(i,1),param(1,1),param(2,1),param(3,1),param(4,1)]));
        end

        sse2=double(sum((ycap-yvalue).^2));

        for i=1:50
            summ=0;
            for j=1:4
                summ=summ+jmat(i,j)*(param1(j,1)-param(j,1));
            end
            z(i)=((ycap(i)-yvalue(i))-(summ))^2;
        end

        chi_new=sum(z);

        param=param1;

        if(abs(chi_new-chi)<10^-15)
            break;
        elseif(chi<chi_new)
            lambda=lambda*k;
            if lambda>10^8
                lambda=lambda/k;
                break;
            end
        elseif(chi>chi_new)
            lambda=lambda/k;
            if lambda<10^-8
                lambda=lambda*k;
                break;
            end
        else
        end
        chi=chi_new;
        n=n+1;
    end


    sst=sum(yvalue.^2)-(sum(yvalue)*sum(yvalue))/50;
    ssr=sst-sse2;
    sigma=sse2/(50-4);
    covmat=sigma./jtj;
    tcalc=zeros(4,1);
    for i=1:4
    tcalc(i,1)=param(i,1)/sqrt(covmat(i,i));
    end
    paramrange=zeros(4,2);
    for i=1:4
    paramrange(i,1)=param(i,1)+sqrt(covmat(i,i))*abs(tinv(0.025,46));
    paramrange(i,2)=param(i,1)-sqrt(covmat(i,i))*abs(tinv(0.025,46));
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
    p(i,1)=1-tcdf(tcalc(i,1),46);
    end
    mssr=ssr/3;
    msse=sse2/46;
    fstat=mssr/msse;
    ftable=zeros(1,2);
    ftable(1,1)=finv(0.05,3,46);
    ftable(1,2)=finv(0.95,3,46);
    if fstat > ftable(1,1) && fstat < ftable(1,2)
    ftest=0;
    else
    ftest=1;
    end
    rsq=1-(sse2/sst);
    msst=sst/49;
    rsqad=1-(msse/msst);
%end
