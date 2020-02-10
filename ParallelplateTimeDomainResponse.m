%==============================
%����һ��ƽ�а崫���ߣ���Ϊ0.1����0.05
%���崫����Ҫ������Ƶ�ʷ�Χ����ʼ����
%���㴫���ߵĴ��亯����ʱ����Ӧ������ͼ��
%���һ��Verilog_A����
%==============================

tline=rfckt.parallelplate('LineLength',0.1,'Width',0.05)    %����ƽ�а崫���߶���
f     =[1.0e9:1e7:2.9e9];           %�涨����Ƶ�ʵķ�Χ
analyze(tline,f)
[S_Params,Freq]=extract(tline,'S_Parameters');
TrFunc=s2tf(S_Params);
RationalFunc=rationalfit(Freq,TrFunc)

[fresp,freq]=freqresp(RationalFunc,Freq);

figure;
plot(freq/1e9,db(fresp),freq/1e9,db(TrFunc));
xlabel('Frequency(GHz)'); ylabel('����(dB)');
title('���ģ�͵����ݺͼ������ݵķ�����Ӧ');

figure;
plot(freq/1e9,unwrap(angle(fresp)),freq/1e9,unwrap(angle(TrFunc)));
xlabel('Frequency(GHz)'); ylabel('Phase(Deg)');
title('���ģ�͵����ݺͼ�������Ƶ����Ӧ����λ��');

SampleTime=1e-12;
NumberOfSamples=1e4;
OverSampleFactor=25;
InputTime=double((1:NumberOfSamples)')*SampleTime;
InputSignal=sign(randn(1,ceil(NumberOfSamples/OverSampleFactor))); %��������ź�
InputSignal=repmat(InputSignal,[OverSampleFactor,1]);
InputSignal=InputSignal(:);

figure;                                                         
[tresp,t]=timeresp(RationalFunc,InputSignal,SampleTime); %����������������źŵ���Ӧ
plot(t*1e9,tresp);                                          %ͼʾ������źŵ���Ӧ
title('Fitting Time-Domain Response');
xlabel('Time(ns)'); ylabel('Response to Random Input Signal');

status=writeva(RationalFunc,'tline','tline_in','tline_out')
type('tline.va')
