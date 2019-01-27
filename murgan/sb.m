function sb(x)
    A = csvread(x);
    X = ones(20,5);
    X(1:20,2:5) = A(1:20,1:4);
    y = A(1:20,5);
    B=(X'*X)\(X'*y)


    for i=1:20
        c(i)=(y(i)-X(i,:)*B)^2;
    end
    SS_error=sum(c) %this is sum of error
    e=SS_error/15


    %calculating range of b values
    cov= inv(X'*X)*e

    t_val1 = -2.131449;
    for j=1:5
        b(j,1)=B(j)+(t_val1)*sqrt(cov(j,j));
        b(j,2)=B(j)-(t_val1)*sqrt(cov(j,j));
    end

    %proving that value of different b is different from zero using t test
    t_val2 = 2.131449;
    for k=1:5
        t_cal= (B(k)/sqrt(cov(k,k)))
        if (t_val1<t_cal && t_cal<t_val2)
            B(k)
        end
    end

    %calculating ss total and ss of regression
    tot=(sum(y.^2)/100);
    z=(y.^2-tot);
    SS_total=sum(z);
    MSS= SS_total/19

    %calculating ss reg
    MSSR=(SS_total-SS_error)/4
    %calc ss error
    e


    %calculating R_square and adjusted value
    R_sqr= 1-(SS_error/SS_total)
    R_adj= 1- (99/95)*(1-R_sqr)
    b
end

    