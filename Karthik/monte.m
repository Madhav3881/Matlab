a = 0;
b = pi/2;
p = 0;
for i = 1:10000
    x = rand(1,1)*b;
    y = rand(1,1)*(1/2);
    t = cos(x)*sin(x);
    if(t>y)
        p = p+1;
    end
end
I = ((b/2)*p)/10000