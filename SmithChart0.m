h=smithchart;
pause(2);
set(h,'Type','ZY','SubColor',[0 1 1]); %change Z-SmithChart to ZY-SmithChart and color the subchart blue
pause(3);
close all;

%在组合的ZY-Smith圆图中标出归一化阻抗值z=0.5+j0.5和归一化导纳值y=1+j2，并求出对应的归一化导纳和阻抗值
hsm=smithchart;
set(hsm,'Type','ZY');
h=rfckt.txline;
analyze(h,1e9);
hold all
circle(h,1e9,'R',0.5,'X',0.5,'Gamma',1,'B',2);
pause(2);
close all;

%特性阻抗恒定的单节短截线匹配网络设计。已知负载阻抗ZL=60-j45，假设短截线和传输线的的特性阻抗均为Z0=75.
%设计两个单节短截线匹配网络将负载变换为Zin=75+j90的输入阻抗。
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


