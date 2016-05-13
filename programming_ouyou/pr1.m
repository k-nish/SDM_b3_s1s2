%A = [1,2,3;4,5,6;7,8,9];
%disp(A)
%A(2,3)

%mu = 2 * 10^(-8);
%disp(mu);
%mu = 4 * pi * 10^(-7);
%disp(mu);
%r_alpha = [i * dx ; j * dy ; 0];
%disp(r_alpha);

r_alpha = [1;2;3];
r_beta = [2;4;6];
r = sum((r_alpha .- r_beta).^2)^(3/2)