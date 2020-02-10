%==============================
%创建一个平行板传输线，长为0.1，宽0.05
%定义传输线要分析的频率范围并开始分析
%计算传输线的传输函数和时域响应并绘制图形
%输出一个Verilog_A描述
%==============================

tline=rfckt.parallelplate('LineLength',0.1,'Width',0.05)    %创建平行板传输线对象
f     =[1.0e9:1e7:2.9e9];           %规定分析频率的范围
analyze(tline,f)
[S_Params,Freq]=extract(tline,'S_Parameters');
TrFunc=s2tf(S_Params);
RationalFunc=rationalfit(Freq,TrFunc)

[fresp,freq]=freqresp(RationalFunc,Freq);

figure;
plot(freq/1e9,db(fresp),freq/1e9,db(TrFunc));
xlabel('Frequency(GHz)'); ylabel('幅度(dB)');
title('拟合模型的数据和计算数据的幅度相应');

figure;
plot(freq/1e9,unwrap(angle(fresp)),freq/1e9,unwrap(angle(TrFunc)));
xlabel('Frequency(GHz)'); ylabel('Phase(Deg)');
title('拟合模型的数据和计算数据频率响应的相位角');

SampleTime=1e-12;
NumberOfSamples=1e4;
OverSampleFactor=25;
InputTime=double((1:NumberOfSamples)')*SampleTime;
InputSignal=sign(randn(1,ceil(NumberOfSamples/OverSampleFactor))); %随机输入信号
InputSignal=repmat(InputSignal,[OverSampleFactor,1]);
InputSignal=InputSignal(:);

figure;                                                         
[tresp,t]=timeresp(RationalFunc,InputSignal,SampleTime); %计算有理函数对随机信号的响应
plot(t*1e9,tresp);                                          %图示对随机信号的响应
title('Fitting Time-Domain Response');
xlabel('Time(ns)'); ylabel('Response to Random Input Signal');

status=writeva(RationalFunc,'tline','tline_in','tline_out')
type('tline.va')
