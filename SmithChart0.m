h=smithchart;
pause(2);
set(h,'Type','ZY','SubColor',[0 1 1]); %change Z-SmithChart to ZY-SmithChart and color the subchart blue
pause(3);
close all;

%����ϵ�ZY-SmithԲͼ�б����һ���迹ֵz=0.5+j0.5�͹�һ������ֵy=1+j2���������Ӧ�Ĺ�һ�����ɺ��迹ֵ
hsm=smithchart;
set(hsm,'Type','ZY');
h=rfckt.txline;
analyze(h,1e9);
hold all
circle(h,1e9,'R',0.5,'X',0.5,'Gamma',1,'B',2);
pause(2);
close all;

%�����迹�㶨�ĵ��ڶ̽���ƥ��������ơ���֪�����迹ZL=60-j45������̽��ߺʹ����ߵĵ������迹��ΪZ0=75.
%����������ڶ̽���ƥ�����罫���ر任ΪZin=75+j90�������迹��
f=1e9;
Z0=75;
ZL=60-j*45;
ZIN=75+j*90;

zl=ZL/Z0
zin=ZIN/Z0
yl=1/zl
yin=1/zin

figure;
hsm=smithchart;
set(hsm,'Type','ZY');

h=rfckt.txline;
analyze(h,f);
hold all;

circle(h,f,'G',[real(yl),real(yin)],'B',[imag(yl),imag(yin)]);
circle(h,f,'Gamma',0.5140,'R',0);
circle(h,f,'B',0.451);


