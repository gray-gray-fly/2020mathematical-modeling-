%问题2求解的各个油箱的优化供油曲线
%%%参数确定！
%%%2020.09.20
clear all;
 [num txt raw]=xlsread('附件3-问题2数据','发动机耗油速度');
% [num txt raw]=xlsread('附件4-问题3数据','发动机耗油数据');
% [num txt raw]=xlsread('附件5-问题4数据','发动机耗油数据');
t=num(:,1);
totall=num(:,2);
m=[0.4, 1.3, 1.2, 0.8, 1.0, 0.45];   
Msum=[255 1275 1785 1615 2210 680];                                        %the maximum of velocity
%  1.1, 1.8, 1.7,  1.5, 1.6, 1.1                                            %the limit of the max vecolity

t1=[10*60:25*60]';
t2=[1:25*60]';
t3=[15*60:50*60]';
t4=[50*60:100*60]';
t5=[50*60:100*60]';
t6=[75*60:100*60]';
ff1=zeros(7200,1);
ff2=zeros(7200,1);
ff3=zeros(7200,1);
ff4=zeros(7200,1);
ff5=zeros(7200,1);
ff6=zeros(7200,1);
ff1(t1)=-m(1)/((t1(1)-t1(end))/2)^2*(t(t1)-t1(1)).*(t(t1)-t1(end));
ff2(t2)=-m(2)/((t2(1)-t2(end))/2)^2*(t(t2)-t2(1)).*(t(t2)-t2(end));
ff3(t3)=-m(3)/((t3(1)-t3(end))/2)^2*(t(t3)-t3(1)).*(t(t3)-t3(end));
ff4(t4)=-m(4)/((t4(1)-t4(end))/2)^2*(t(t4)-t4(1)).*(t(t4)-t4(end));
ff5(t5)=-m(5)/((t5(1)-t5(end))/2)^2*(t(t5)-t5(1)).*(t(t5)-t5(end));
ff6(t6)=-m(6)/((t6(1)-t6(end))/2)^2*(t(t6)-t6(1)).*(t(t6)-t6(end));

f=ff2+ff3+ff4+ff5;
SS=sum(totall(1:t2(end)))
S=sum(f(1:t1(end)))
S1=sum(ff1);S2=sum(ff2);S3=sum(ff3);S4=sum(ff4);S5=sum(ff5);S6=sum(ff6);
M=[S1 S2 S3 S4 S5 S6]
[255 1275 1785 1615 2210 680]

figure;
plot(t,totall,'Linewidth',5)
hold on
% c=totall-ff2;
plot(t,f,'Linewidth',5)
grid minor
title('4个主油箱总的供油的速度')
xlabel('时间（s）')
ylabel('供油速度（kg/s）')
legend('计划耗油速度','4个主油箱的供油速度')

figure;
plot(t,ff1,'Linewidth',5)
hold on
plot(t,ff2,'Linewidth',5)
hold on
plot(t,ff3,'Linewidth',5)
hold on
plot(t,ff4,'Linewidth',5)
hold on
plot(t,ff5,'Linewidth',5)
hold on
plot(t,ff6,'Linewidth',5)
grid minor
legend('油箱1','油箱2','油箱3','油箱4','油箱5','油箱6')
title('6个油箱各自的供油的速度')
xlabel('时间（s）')
ylabel('供油速度（kg/s）')
figure;
for i=1:7200
    sf(i)=sum(totall(1:i));
    pf(i)=sum(f(1:i));
end
cf=pf-sf;
plot(t/60,cf)