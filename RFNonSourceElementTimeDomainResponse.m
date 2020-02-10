%==============================
%使用文件passive.s2p中的数据创建一个RF无源器件，
%计算并图示该RF无源元件，计算并图示该RF元件的
%时域响应。
%==============================

PassiveCkt=rfckt.passive('File','passive.s2p') %用文件passive.s2p创建RF电路对象
z0=50; zs=50; zl=50;                                   %参考阻抗为z0，源阻抗为zs，负载阻抗为zl
[SParams,Freq]=extract(PassiveCkt,'S Parameters',z0); %提取无源电路对象S参数
TransFunc=s2tf(SParams,z0,zs,zl);               %调用函数s2tf计算传输函数
RationalFunc=rationalfit(Freq,TransFunc)    %调用有理函数RationalFunc对传输函数拟合
nPoles=length(RationalFunc.A)                   %计算有理函数的极点数量（模型对象A矢量长度决定）
Resp=freqresp(RationalFunc,Freq);              %有理函数频率响应

plot(Freq,20*log10(abs(TransFunc)),'r',Freq,20*log10(abs(Resp)),'b--'); %验证模型适合程度
xlabel('Frequency(Hz)');
ylabel('传输函数的幅度(dB)');
title('原始数据和拟合数据的比较');

SampleTime=1e-11;                                   %抽样时间10ns
NumberOfSamples=4750;                          %抽样点数
OverSampleFactor=25;                               %抽样因子
InputTime=double((1:NumberOfSamples)')*SampleTime; %输入随机信号的时间
InputSignal=sign(randn(1,ceil(NumberOfSamples/OverSampleFactor))); %随机输入信号
InputSignal=repmat(InputSignal,[OverSampleFactor,1]);
InputSignal=InputSignal(:);

figure;                                                         
[tresp,t]=timeresp(RationalFunc,InputSignal,SampleTime); %计算有理函数对随机信号的响应
plot(t*1e9,tresp);                                          %图示对随机信号的响应
title('Fitting Time-Domain Response');
xlabel('Time(ns)'); ylabel('Response to Random Input Signal');
