% ��ⳬ���η���
% ������ʼʱ�̺ͷ���ʱ�̵ĺ�����ϵ
x=0.001:0.01:1.57;
for i=1:numel(x)
    f=@(y)cos(y)-cos(x(i))+(y-x(i)).*sin(x(i));
    y(i)=fzero(f,1);
    E(i)=2.*(sin(y(i))-sin(x(i))).^2;
end
plot(x,E)
% ��������
% X=input('����t0��ֵ');
% Y=input('����t��ֵ');
% E=2.*(sin(Y)-sin(X)).^2;
% plot(X,E);

