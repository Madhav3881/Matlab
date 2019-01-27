function abc(x1,y1,x2,y2,t)
    f = @(x)((y2-y1)/(x2-x1))*(x-x1) + y1;
    P = feval(f,t)
end