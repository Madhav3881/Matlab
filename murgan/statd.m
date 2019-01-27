function ds = statd(x)
    A = csvread(x);
    A1=A(:,1);
    B=A(:,2);
    C=A(:,3);
    D=A(:,4);
    E=A(:,5);
    r=0;
    e = zeros(10,5);
    S=[A1 B C D E];
    for i=1:5
        for j=i+1:5  
            r=r+1;
            h= vartest2(S(1:20,i),S(1:20,j),'alpha',0.04354);
            if h==0
             [h,p,c1,stat]=ttest2(S(1:20,i),S(1:20,j),'alpha',0.04354,'Vartype','equal');
            else
              [h,p,c1,stat]=ttest2(S(1:20,i),S(1:20,j),'alpha',0.04354,'Vartype','unequal');
            end
           e(r,1:5)=[r stat.tstat p c1'];
        end
    end
    ds = array2table(e,'VariableNames',{'SNo','tvalue','pvalue','range_i','range_f'});
end