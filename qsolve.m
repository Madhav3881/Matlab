function f = qsolve(a,b,c,h)
    d = (b*b)-4*(a*c);
    if d >= 0
        r1 = (-b+sqrt(d))/(2*a);
        r2 = (-b-sqrt(d))/(2*a);
        r1 = round(r1,h,'significant');
        r2 = round(r2,h,'significant');
        disp(r1);
        disp(r2);
    else
        disp("imaginary roots")
    end
end