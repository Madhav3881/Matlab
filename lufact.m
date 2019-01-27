function X = lufact(A,b)
    sz = size(A);
    L = zeros(sz(1),sz(2));
    U = zeros(sz(1),sz(2));
    b1 = b;
    for i = 1:sz(1)
        for j = i+1:sz(1)
            L(i,j) =  A(i,j)/A(i,i);
            b1(j) = b1(j)-(b1(i)*L(i,j));
            for k = 1:sz(1)
                U(j,k) = A(i,j)-(A(i,k)*L(i,j));
            end
        end
    end
    disp(L);
    disp(U);
end