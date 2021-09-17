% 求解超几何方程
% 计算起始时刻和返回时刻的函数关系
x=0.001:0.01:1.57;
for i=1:numel(x)
    f=@(y)cos(y)-cos(x(i))+(y-x(i)).*sin(x(i));
    y(i)=fzero(f,1);
    E(i)=2.*(sin(y(i))-sin(x(i))).^2;
end
plot(x,E)
% 计算能量
% X=input('调用t0的值');
% Y=input('调用t的值');
% E=2.*(sin(Y)-sin(X)).^2;
% plot(X,E);

