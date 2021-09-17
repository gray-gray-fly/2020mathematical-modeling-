clearvars -except ff1 ff2 ff3 ff4 ff5 ff6
[num txt raw]=xlsread('附件3-问题2数据','飞行器理想质心数据');
% [num2 txt raw]=xlsread('附件3-问题2数据','发动机耗油速度');
% [num3 txt raw]=xlsread('附件2-问题1数据','油箱供油曲线');

% [num4 txt raw]=xlsread('供油速度','sheet');    %simulate supply fuel plan
% figure;
rr=sqrt(num(:,2).^2+num(:,3).^2+num(:,4).^2);
% plot(num(:,1)/60,rr,'Linewidth',2)
% title('时间与飞机质心的变化')
% xlabel('min（时间）')
% figure;
% plot(num2(:,1)/60,num2(:,2),'Linewidth',2)
% title('时间与总的耗油速度的关系')
% xlabel('min(时间)'),ylabel('总耗油速度')

density=850;
V=[ 1.5 0.9	0.3;                               %volume
    2.2	0.8	1.1;
    2.4 1.1	0.9;                             
    1.7	1.3	1.2;
    2.4	1.2	1  ;
    2.4 1   0.5];

position=[8.16304348	9.66304348	0.75652174	1.65652174	0.46669004	0.76669004;
          5.81304348	8.01304348	-1.7934783	-0.9934783	-0.33331	0.76669004;
          -2.8869565	-0.4869565	0.65652174	1.75652174	-0.73331	0.16669004;
          2.26304348	3.96304348	-0.0434783	1.25652174	-0.78331	0.41669004;
          -6.4869565	-4.0869565	-0.8934783	0.30652174	-0.08331	0.91669004;
          -3.2869565	-0.8869565	-1.9934783	-0.9934783	-0.03331	0.46669004];
t=num(:,1);
fuel=[ff1, ff2, ff3, ff4, ff5, ff6];


rx=zeros(7200,6);                                            %center of mass
ry=zeros(7200,6);
rz=zeros(7200,6);
restfuel=zeros(7200,6);

restfuel(1,1:6)=[255 1275 1785 1615 2210 680];   %initial data
for i=2:7200                                     %every second
    for j=1:6
        if j==2
            restfuel(i,j)=restfuel((i-1),j)-fuel(i,j)+fuel(i,1);
        elseif j==5
            restfuel(i,j)=restfuel((i-1),j)-fuel(i,j)+fuel(i,6);
        else
            restfuel(i,j)=restfuel((i-1),j)-fuel(i,j);
        end
         result=NACenter(restfuel(i,j),position(j,:),V(j,1:3));
         rx(i,j)=result(1);
         ry(i,j)=result(2);
         rz(i,j)=result(3);
    end
end

xx=rx.*restfuel;
yy=ry.*restfuel;
zz=rz.*restfuel;
cx=(xx(:,1)+xx(:,2)+xx(:,3)+xx(:,4)+xx(:,5)+xx(:,6))/(restfuel(:,1)+restfuel(:,2)+restfuel(:,3)+restfuel(:,4)+restfuel(:,5)+restfuel(:,6)+3000);
cy=(yy(:,1)+yy(:,2)+yy(:,3)+yy(:,4)+yy(:,5)+yy(:,6))/(restfuel(:,1)+restfuel(:,2)+restfuel(:,3)+restfuel(:,4)+restfuel(:,5)+restfuel(:,6)+3000);
cz=(zz(:,1)+zz(:,2)+zz(:,3)+zz(:,4)+zz(:,5)+zz(:,6))/(restfuel(:,1)+restfuel(:,2)+restfuel(:,3)+restfuel(:,4)+restfuel(:,5)+restfuel(:,6)+3000);
r=sqrt(cx.^2+cy.^2+cz.^2);
cc=(num(:,2)-cx(:,1)).^2+(num(:,3)-cy(:,1)).^2+(num(:,4)-cz(:,1)).^2;
figure;
rn=r(:,1);
plot(t(2:end),rn(2:end),'LineWidth',5)
hold on
plot(t(2:end),rr(2:end),'Linewidth',5)
title('质心位置')
xlabel('时间（s）')
ylabel('与原点的距离')
% cc=rn(2:end)-rr(2:end);
grid minor
legend('飞行器质心','理想质心')
% figure;
% plot(num(:,1)/60,cc,'Linewidth',2)
max(abs(cc))

function result=NACenter(rest,position,V)
    density=850;
    x1=position(1);
    x2=position(2);
    y1=position(3);
    y2=position(4);
    newV=rest/density;
    h=newV/V(:,1)/V(:,2);
    x=1/newV*V(:,2)*h*0.5*(x2^2-x1^2);
    y=1/newV*V(:,1)*h*0.5*(y2^2-y1^2);
    z=1/newV*0.5*h^2*V(:,1)*V(:,2);
    result=[x y z];
end