clear
[num1 txt raw]=xlsread('����2-����1����','���乩������');
fuel=num1(:,2:end);
fueltotal=fuel(:,2)+fuel(:,3)+fuel(:,4)+fuel(:,5);
figure;
plot(num1(:,1)/60,fueltotal,'Linewidth',2)
title('������ĺ����ٶȣ�2��3��4��5��')
xlabel('min��ʱ�䣩')
figure;
for i=1:6
    plot(num1(:,1)/60,fuel(:,i),'Linewidth',2)
    hold on
end
xlabel('min��ʱ�䣩')
legend('No.1','No.2','No.3','No.4','No.5','No.6')
title('6������Ĺ����ٶ�')

[num2 txt raw]=xlsread('����3-����2����','������������������');
figure;
r=sqrt(num2(:,2).^2+num2(:,3).^2+num2(:,4).^2);
plot(num2(:,1)/60,r,'Linewidth',2)
title('ʱ����ɻ����ĵı仯')
xlabel('min��ʱ�䣩')
% figure;
% plot3(num2(:,2),num2(:,3),num2(:,4))
% xlabel('x'),ylabel('y'),zlabel('z')
% title('three-dimension')
figure;
[num3 txt raw]=xlsread('����2-����1����','������������');
plot(num3(:,1)/60,num3(:,2),'Linewidth',2)
title('ʱ���븩���ǵĹ�ϵ')
xlabel('min(ʱ��)'),ylabel('�Ƕ�')
figure;
[num4 txt raw]=xlsread('����3-����2����','�����������ٶ�');
plot(num4(:,1)/60,num4(:,2),'Linewidth',2)
title('ʱ�����ܵĺ����ٶȵĹ�ϵ')
xlabel('min(ʱ��)'),ylabel('�ܺ����ٶ�')

[num5 txt raw]=xlsread('����4-����3����','��������������');
figure;
r=sqrt(num5(:,2).^2+num5(:,3).^2+num5(:,4).^2);
plot(num5(:,1)/60,r,'Linewidth',2)
title('ʱ����ɻ����ĵı仯')
xlabel('min��ʱ�䣩')
figure;
[num6 txt raw]=xlsread('����4-����3����','��������������');
plot(num6(:,1)/60,num6(:,2),'Linewidth',2)
title('ʱ�����ܵĺ����ٶȵĹ�ϵ')
xlabel('min(ʱ��)'),ylabel('�ܺ����ٶ�')

figure;
[num7 txt raw]=xlsread('����5-����4����','��������������');
plot(num7(:,1)/60,num7(:,2),'Linewidth',2)
title('ʱ�����ܵĺ����ٶȵĹ�ϵ')
xlabel('min(ʱ��)'),ylabel('�ܺ����ٶ�')
figure;
[num8 txt raw]=xlsread('����5-����4����','������������');
plot(num8(:,1)/60,num8(:,2),'Linewidth',2)
title('ʱ���븩���ǵĹ�ϵ')
xlabel('min(ʱ��)'),ylabel('�Ƕ�')
 

