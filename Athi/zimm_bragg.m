function z = zimm_bragg(n)
    syms s sg z;
    z = [1,sg*s]*([1,sg*s;1,s]^(n-1))*[1;1];
end