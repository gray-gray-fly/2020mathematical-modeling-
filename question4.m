clearvars -except ff1 ff2 ff3 ff4 ff5 ff6
[num1 txt raw]=xlsread('附件5-问题4数据','发动机耗油数据');
[num2 txt raw]=xlsread('附件5-问题4数据','飞行器俯仰角');
% rr=sqrt(num(:,2).^2+num(:,3).^2+num(:,4).^2);
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
x1=position(1,:);
x2=position(2,:);
y1=position(3,:);
y2=position(4,:);
z1=position(5,:);
z2=position(6,:);

t=num1(:,1);
fuel=[ff1 ff2 ff3 ff4 ff5 ff6];
angle=num2(:,2);

rx=zeros(7200,6);                                            %center of mass
ry=zeros(7200,6);
rz=zeros(7200,6);
restfuel=zeros(7200,6);

restfuel(1,1:6)=[255 1275 1785 1615 2210 680];   %initial data
for i=2:length(angle)                           %every second
    for j=1:6
        if j==2
            restfuel(i,j)=restfuel((i-1),j)-fuel(i,j)+fuel(i,1);
        elseif j==5
            restfuel(i,j)=restfuel((i-1),j)-fuel(i,j)+fuel(i,6);
        else
            restfuel(i,j)=restfuel((i-1),j)-fuel(i,j);
        end
        if i>=3545 & j==1 
            rx(i,j)=0;
            ry(i,j)=0;
            rz(i,j)=0;
            continue;
        end
         if angle(i)==0 | (j==2 & i>=3979 & i<=4896) | (j==3 & i>=3523 & i<=5782) || (j==4 & i>=3962 & i<=5780)
            result=NACenter(restfuel(i,j),position(j,:),V(j,1:3));
            rx(i,j)=result(1);
            ry(i,j)=result(2);
            rz(i,j)=result(3);
            
%             h(i,j)=result;
          else
              result=ACenter(restfuel(i,j),-angle(i)*pi/180,position(j,:),V(j,1:3));
              rx(i,j)=result(1);
              ry(i,j)=result(2);
              rz(i,j)=result(3);
              b(i,j)=result(4);
              if rz(i,j)<z1(1,j) | rz(i,j)>z1(1,j)
                  result=NACenter(restfuel(i,j),position(j,:),V(j,1:3));
                  rx(i,j)=result(1);
                  ry(i,j)=result(2);
                  rz(i,j)=result(3);
              end
        end
    end
end


xx=rx.*restfuel;
yy=ry.*restfuel;
zz=rz.*restfuel;
cx=(xx(:,1)+xx(:,2)+xx(:,3)+xx(:,4)+xx(:,5)+xx(:,6))/(restfuel(:,1)+restfuel(:,2)+restfuel(:,3)+restfuel(:,4)+restfuel(:,5)+restfuel(:,6)+3000);
cy=(yy(:,1)+yy(:,2)+yy(:,3)+yy(:,4)+yy(:,5)+yy(:,6))/(restfuel(:,1)+restfuel(:,2)+restfuel(:,3)+restfuel(:,4)+restfuel(:,5)+restfuel(:,6)+3000);
cz=(zz(:,1)+zz(:,2)+zz(:,3)+zz(:,4)+zz(:,5)+zz(:,6))/(restfuel(:,1)+restfuel(:,2)+restfuel(:,3)+restfuel(:,4)+restfuel(:,5)+restfuel(:,6)+3000);
r=sqrt(cx.^2+cy.^2+cz.^2);
rn=r(:,1);
plot(t(2:end),rn(2:end),'LineWidth',5)
% hold on
% plot(t(2:end),rr(2:end),'Linewidth',5)
title('质心位置')
xlabel('时间（s）')
ylabel('与原点的距离')
% cc=rn(2:end)-rr(2:end);
grid minor

% figure;
% plot(num(:,1)/60,cc,'Linewidth',2)
max(abs())


function result=NACenter(rest,position,V)
    density=850;
    x1=position(1);
    x2=position(2);
    y1=position(3);
    y2=position(4);
%     z1=position(5);
%     z2=position(6);
    newV=rest/density;
    h=newV/V(:,1)/V(:,2);
    x=1/newV*V(:,2)*h*0.5*(x2^2-x1^2);
    y=1/newV*V(:,1)*h*0.5*(y2^2-y1^2);
    z=1/newV*0.5*h^2*V(:,1)*V(:,2);
    result=[x y z];
end

 function result=ACenter(rest,ang,position,V)
    density=850;
    restS=rest/density/(V(:,2));
    newV=rest/density;
    x1=position(1);
    x2=position(2);
    y1=position(3);
    y2=position(4);
    z1=position(5);
    z2=position(6);
    h=newV/restS;
    if h<=0.01
        result=[0 0 0];
        return;
    end
    
    if ang<atan(V(:,3)/V(:,1))
        if restS<V(:,1)^2*tan(ang)*0.5
%             result=triangle_1;
            f=@(b)(tan(ang)*x1+b-z1)*((z1-b)/tan(ang)-x1)*0.5-restS;
            b=fzero(f,1);
%             b=-0.1;
            x=1/newV*(y2-y1)*(1/3*tan(ang)*((z1-b)/tan(ang))^3+1/2*((z1-b)/tan(ang))^2*(b-z1)-1/3*x1^3*tan(ang)+1/2*x1^2*(b-z1));
            y=1/newV*0.5*(y2^2-y1^2)*(0.5*((z1-b)/tan(ang))^2*tan(ang)+(b-z1)*(z1-b)/tan(ang)-0.5*x1^2*tan(ang)-(b-z1)*x1);
            z=1/newV*(y2-y1)*(1/3/tan(ang)*(x1*tan(ang)+b)^3-0.5*(b/tan(ang)+x1)*(x1*tan(ang)+b)^2-z1^3/3/tan(ang)+0.5*(b/tan(ang)+x1)*z1^2);
        else
%             result=pentagon;
            f=@(b)(tan(ang)*x1+b-z1+tan(ang)*x2+b-z1)*(x2-x1)*0.5-restS;
            b=fzero(f,1);
%             b=-0.1;
            x=1/newV*(y2-y1)*(1/3*x2^3*tan(ang)+0.5*(b-z1)*x2^2-1/3*x1^3*tan(ang)-0.5*(b-z1)*x1^2);
            y=1/newV*0.5*(y2^2-y1^2)*(0.5*x2^2*tan(ang)+(b-z1)*x2-0.5*x1^2*tan(ang)-(b-z1)*x1);
            z=1/newV*(y2-y1)*(1/6*x2^3*tan(ang)^2+0.5*(b-z1)*x2^2*tan(ang)+0.5*x2*(b-z1)^2-1/6*x1^3*tan(ang)^2-0.5*(b-z1)*x1^2-0.5*x1*(b-z1)^2);
%             z=1/newV*(y2-y1)*(1/3*(x1*tan(ang))^3/tan(ang)-0.5*(b/tan(ang)+x1)*(x1*tan(ang)+b)^2-1/3*z1^3/tan(ang)+0.5*(b/tan(ang)+x1)*z1^2);
        end
    else
        if restS<V(:,3)^2/tan(ang)*0.5
%             result=tiangle_2;
            f=@(b)((z1-b)/tan(ang)-x1)*(x1*tan(ang)+b-z1)*0.5-restS;
            b=fzero(f,1);
%             b=-0.1;
            x=1/newV*(y2-y1)*(1/3*((z1-b)/tan(ang))^3*tan(ang)+0.5*(b-z1)*((z1-b)/tan(ang))^2-1/3*x1^3*tan(ang)-0.5*(b-z1)*x1^2);
            y=1/newV*0.5*(y2^2-y1^2)*(0.5*((z1-b)/tan(ang))^2*tan(ang)+(b-z1)*(b-z1)/tan(ang)-0.5*x1^2*tan(ang)-(b-z1)*x1);
            z=1/newV*(y2-y1)*(1/(3*tan(ang))*(x1*tan(ang)+b)^3-0.5*(b/tan(ang)+x1)*(x1*tan(ang)+b)^2-1/(3*tan(ang))*z1^3+0.5*(b/tan(ang)+x1)*z1^2);
        else
%             result=trapezoid;
            f=@(b)((z1-b)/tan(ang)-x1+(z2-b)/tan(ang)-x1)*(z2-z1)*0.5-restS;
            b=fzero(f,1);
%             b=-0.1;
            x=1/newV*(y2-y1)*0.5*((1/3*z2^3/tan(ang)^2-(b/tan(ang)+x1)*z2^2/tan(ang)+(b/tan(ang)+x1)^2*z2)-(1/3*z1^3/tan(ang)^2-(b/tan(ang)+x1)*z1^2/tan(ang)+(b/tan(ang)+x1)^2*z1));
            y=1/newV*0.5*(y2^2-y1^2)*(z2^2/(2*tan(ang))-(b/tan(ang)+x1)*z2-z1^2/(2*tan(ang))+(b/tan(ang)+x1)*z1);
            z=1/newV*(y2-y1)*(1/(3*tan(ang))*z2^3-0.5*(b/tan(ang)+x1)*z2^2-1/(3*tan(ang))*z1^3+0.5*(b/tan(ang)+x1)*z1^2);
        end
    end
    result=[x y z b];
 end
