clear
[num1 txt raw]=xlsread('附件2-问题1数据','油箱供油曲线');
fuel=num1(:,2:end);
fueltotal=fuel(:,2)+fuel(:,3)+fuel(:,4)+fuel(:,5);
figure;
plot(num1(:,1)/60,fueltotal,'Linewidth',2)
title('主油箱的耗油速度（2，3，4，5）')
xlabel('min（时间）')
figure;
for i=1:6
    plot(num1(:,1)/60,fuel(:,i),'Linewidth',2)
    hold on
end
xlabel('min（时间）')
legend('No.1','No.2','No.3','No.4','No.5','No.6')
title('6个油箱的供油速度')

[num2 txt raw]=xlsread('附件3-问题2数据','飞行器理想质心数据');
figure;
r=sqrt(num2(:,2).^2+num2(:,3).^2+num2(:,4).^2);
plot(num2(:,1)/60,r,'Linewidth',2)
title('时间与飞机质心的变化')
xlabel('min（时间）')
% figure;
% plot3(num2(:,2),num2(:,3),num2(:,4))
% xlabel('x'),ylabel('y'),zlabel('z')
% title('three-dimension')
figure;
[num3 txt raw]=xlsread('附件2-问题1数据','飞行器俯仰角');
plot(num3(:,1)/60,num3(:,2),'Linewidth',2)
title('时间与俯仰角的关系')
xlabel('min(时间)'),ylabel('角度')
figure;
[num4 txt raw]=xlsread('附件3-问题2数据','发动机耗油速度');
plot(num4(:,1)/60,num4(:,2),'Linewidth',2)
title('时间与总的耗油速度的关系')
xlabel('min(时间)'),ylabel('总耗油速度')

[num5 txt raw]=xlsread('附件4-问题3数据','飞行器理想质心');
figure;
r=sqrt(num5(:,2).^2+num5(:,3).^2+num5(:,4).^2);
plot(num5(:,1)/60,r,'Linewidth',2)
title('时间与飞机质心的变化')
xlabel('min（时间）')
figure;
[num6 txt raw]=xlsread('附件4-问题3数据','发动机耗油数据');
plot(num6(:,1)/60,num6(:,2),'Linewidth',2)
title('时间与总的耗油速度的关系')
xlabel('min(时间)'),ylabel('总耗油速度')

figure;
[num7 txt raw]=xlsread('附件5-问题4数据','发动机耗油数据');
plot(num7(:,1)/60,num7(:,2),'Linewidth',2)
title('时间与总的耗油速度的关系')
xlabel('min(时间)'),ylabel('总耗油速度')
figure;
[num8 txt raw]=xlsread('附件5-问题4数据','飞行器俯仰角');
plot(num8(:,1)/60,num8(:,2),'Linewidth',2)
title('时间与俯仰角的关系')
xlabel('min(时间)'),ylabel('角度')
 

