% Data = xlsread('data.xls','加入者','B13:E');
% Data_t = transpose(Data);

% for i =
clear all;

DATA=csvread('data.csv','加入者','B13:D392');
DATA_t=transpose(DATA);
A=[];
for i=0:90
    a=DATA_t(3,133+i:133+i+29);
    A=[A a];
end
