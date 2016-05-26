clear all;
C = csvread('data.csv');
C_t = transpose(C);
A=[];
for i=0:90
    a=C_t(3,133+i:133+i+29);
    A=[A a];
end

A_t = transpose(A);
a_0 = 1/91 * A_t * ones(91,1);
A_2 = A_t - a_0 + ones(1,91);
B = A_2 * transpose(A_2);

[W,D] = eigs(B,30);

L = zeros(30,1);
L(1,1) = 1;
Q0 = C_t(3,133+90+1:133+90+29);
Q = [0,transpose(Q0)];

a_t1 = (L.' * W * W.' )
