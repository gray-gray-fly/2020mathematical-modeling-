clear all;
[num txt raw]=xlsread('附件2-问题1数据','油箱供油曲线');
t=num(:,1);
fuel1=num(:,2);
fuel2=num(:,3);
fuel3=num(:,4);
fuel4=num(:,5);
fuel5=num(:,6);
fuel6=num(:,7);

index1=find(fuel1);
index2=find(fuel2);
index3=find(fuel3);
index4=find(fuel4);
index5=find(fuel5);
index6=find(fuel6);

f1=fuel1(index1);t1=t(index1);
f2=fuel2(index2);t2=t(index2);ff2=-1/1200/1200*t.*(t-2400);
f3=fuel3(index3);t3=t(index3);
f4=fuel4(index4);t4=t(index4);
f5=fuel5(index5);t5=t(index5);
f6=fuel6(index6);t6=t(index6);
% [c3,ff,gg]=fit(t(a)',fuel1(a)','Fourier2');
% cc(nn,:)=c3(x);
usefuel=[254.0712651 1164.294719 1592.290435 887.6501943 1960.777778 635.6385242];
