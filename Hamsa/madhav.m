function madhav(T,y)
    A1 = 7.11714;
    B1 = 1210.595;
    C1 = 229.664;
    A2 = 8.08097;
    B2 = 1582.271;
    C2 = 239.726;
    P1_sat = 0.133322*(10^(A1-(B1/(T+C1))));
    P2_sat = 0.133322*(10^(A2-(B2/(T+C2))));
    a = 0.6184;
    b = 0.5797;
    epsiolon = 1e-8;
    x = 0;
    i =0;
    while 1
        i = i+1;
        g1 = exp(a/(1+((a*x)/(b*(1-x))))^2);
        g2 = exp(b/(1+((b*(1-x))/(a*x)))^2);
        P1 = (x*g1*P1_sat)/y;
        P2 = ((1-x)*g2*P2_sat)/(1-y);
        P = (P1+P2)/2;
        x = (P*y)/(g1*P1_sat);
        if(abs(P2-P1)<epsiolon)
            P = P1;
            liq = x;
            break
        end
    end
    format long
    liquid_fraction_1 = liq
    Pressure = P
    Interations = i
end