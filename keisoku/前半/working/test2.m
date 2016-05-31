clear all;
t_end=3650;%380
t=2920;%301
n=t;%t
m=365;%100
k=5;%5
t_mid=10;

DATA=csvread('data1.csv');
%preD=DATA(1:t,1);
data = DATA(1:t_end,1);
preD=DATA(1:t,1);

for it_0=t:t_mid:t_end
    A=[];

    for i=it_0-n+m:it_0
        %a=DATA(i:-1:i-m+1,3);
        a=DATA(i:-1:i-m+1,1);
        A=[A a];
    end
    a_0 = 1/(n-m+1) * A * ones(n-m+1,1);
    A_2 = A - a_0 * ones(1,n-m+1);
    B = A_2 * A_2';

    [W,D] = eigs(B,k);

    L=zeros(m,1);

    L(1,1)=1;

    for it=it_0+1:it_0+t_mid
        q = preD(it-1:-1:it-m+1);
        Q = [0; q];
        preD(it) = (L'*W*W'*(Q-a_0)+a_0(1,1))/(1-L'*(W*W')*L);
    end
end

figure(1)
plot(1:t_end,data(:,1),'b',t+1:t_end,preD(t+1:t_end),'r');
%plot(1:t_end,DATA(:,3),'b',t+1:t_end,preD(t+1:t_end),'r');
