function Q4(m)
    syms b1 b2 b3 b x 'd'
    %values of x,y

    f(x,b,b1,b2,b3)=exp(-(x-b1)^2/2*b^2)/(sqrt(2*pi)*b)+exp(-(x-b3)^2/2*b2^2)/(sqrt(2*pi)*b2);
    %x1= [-5 -4.7 -4.4 -4.1 -3.8 -3.5 -3.2 -2.9 -2.6 -2.3 -2 -1.7 -1.4 -1.1 -0.8 -0.5 -0.2 0.1 0.4 0.7 1 1.3 1.6 1.9 2.2 2.5 2.8 3.1 3.4 3.7 4 4.3 4.6 4.9 5.2 5.5 5.8 6.1 6.4 6.7 7 7.3 7.6 7.9 8.2 8.5 8.8 9.1 9.4 9.7]';
    %y= [0.032041 0.021207 -0.046636 0.021967 0.045838 0.017431 0.021749 0.089429 0.0094814 0.0050137 -0.022386 0.034651 0.040425 0.05603 0.13413 0.080439 0.25251 0.26656 0.33898 0.30875 0.28878 0.30889 0.25794 0.26148 0.27979 0.10199 0.12595 0.12118 0.11832 0.027594 0.070627 0.080889 0.10297 0.15322 0.34466 0.34657 0.29391 0.36049 0.37945 0.25461 0.32656 0.19686 0.16955 0.09129 0.089962 0.0092645 -0.0044632 0.012528 -0.051325 -0.045883 ]';
    
    A = csvread(m);
    x1 = A(:,1);
    y = A(:,2);
    
    a1(b,b1,b2,b3)=diff(f(x1,b,b1,b2,b3),b);
    a2(b,b1,b2,b3)=diff(f(x1,b,b1,b2,b3),b1);
    a3(b,b1,b2,b3)=diff(f(x1,b,b1,b2,b3),b2);
    a4(b,b1,b2,b3)=diff(f(x1,b,b1,b2,b3),b3);
    %it's jacobian matrix

    J=[a1,a2,a3,a4];
    lem=5;
    k=2;
    b=1;
    b1=1;
    b2=1;
    b3=1;
    del_y= (y-f(x1,1,1,1,1));
    del_y=double(del_y);


    B= [1;1;1;1]+(J(1,1,1,1)'*J(1,1,1,1)+lem*diag(J(1,1,1,1)'*J(1,1,1,1)))\(J(1,1,1,1)'*del_y);
    B=double(B);

    b1=B(2); 
    b2=B(3); 
    b3=B(4); 
    b=B(1);

    z=(del_y-a1(b,b1,b2,b3)*(b-1)-a2(b,b1,b2,b3)*(b1-1)-a3(b,b1,b2,b3)*(b2-1)-a4(b,b1,b2,b3)*(b3-1)).^2;
    chi=sum(z);
    chi=double(chi)
    j=0;
    while true

        j=1+j
        del_y= (y-f(x1,b,b1,b2,b3));
        del_y=double(del_y);
        d=J(b,b1,b2,b3); %jacobian matrix
        d=double(d);
        B=[b;b1;b2;b3]+(d'*d+lem*diag(d'*d))\(d'*del_y);
        B=double(B);
        z=(del_y-a1(B(1),B(2),B(3),B(4))*(B(1)-b)-a2(B(1),B(2),B(3),B(4))*(B(2)-b1)-a3(B(1),B(2),B(3),B(4))*(B(3)-b2)-a4(B(1),B(2),B(3),B(4))*(B(4)-b3)).^2;
        z=double(z);
        chi_new=sum(z)
        if ((chi_new-chi)>1)      
            lem=lem*k
        elseif(abs(chi_new-chi)<10^(-15))
            B;
            lem;
            break
        elseif (abs(chi_new-chi)<1)
            lem=lem/k


        end

        chi=chi_new;
        b1=B(2); 
        b2=B(3); 
        b3=B(4); 
        b=B(1);

    end

    sse=(y-f(x1,B(1),B(2),B(3),B(4))).^2;
    SSE=sum(sse);
    MSSE=SSE/46;
    MSSE=double(MSSE)

    tot=sum((y.^2)/100);
    sst= y.^2-tot;
    SST=sum(sst);
    MSST=SST/49

    SSR=SST-SSE;
    MSSR=SSR/3;
    MSSR=double(MSSR)

    R_sqr= 1-(SSE/SST);
    R_sqr=double(R_sqr)
    R_adj= 1- (49/46)*(1-R_sqr)
end

 






 









    
  
   