%==============================
%ʹ���ļ�passive.s2p�е����ݴ���һ��RF��Դ������
%���㲢ͼʾ��RF��ԴԪ�������㲢ͼʾ��RFԪ����
%ʱ����Ӧ��
%==============================

PassiveCkt=rfckt.passive('File','passive.s2p') %���ļ�passive.s2p����RF��·����
z0=50; zs=50; zl=50;                                   %�ο��迹Ϊz0��Դ�迹Ϊzs�������迹Ϊzl
[SParams,Freq]=extract(PassiveCkt,'S Parameters',z0); %��ȡ��Դ��·����S����
TransFunc=s2tf(SParams,z0,zs,zl);               %���ú���s2tf���㴫�亯��
RationalFunc=rationalfit(Freq,TransFunc)    %����������RationalFunc�Դ��亯�����
nPoles=length(RationalFunc.A)                   %�����������ļ���������ģ�Ͷ���Aʸ�����Ⱦ�����
Resp=freqresp(RationalFunc,Freq);              %������Ƶ����Ӧ

plot(Freq,20*log10(abs(TransFunc)),'r',Freq,20*log10(abs(Resp)),'b--'); %��֤ģ���ʺϳ̶�
xlabel('Frequency(Hz)');
ylabel('���亯���ķ���(dB)');
title('ԭʼ���ݺ�������ݵıȽ�');

SampleTime=1e-11;                                   %����ʱ��10ns
NumberOfSamples=4750;                          %��������
OverSampleFactor=25;                               %��������
InputTime=double((1:NumberOfSamples)')*SampleTime; %��������źŵ�ʱ��
InputSignal=sign(randn(1,ceil(NumberOfSamples/OverSampleFactor))); %��������ź�
InputSignal=repmat(InputSignal,[OverSampleFactor,1]);
InputSignal=InputSignal(:);

figure;                                                         
[tresp,t]=timeresp(RationalFunc,InputSignal,SampleTime); %����������������źŵ���Ӧ
plot(t*1e9,tresp);                                          %ͼʾ������źŵ���Ӧ
title('Fitting Time-Domain Response');
xlabel('Time(ns)'); ylabel('Response to Random Input Signal');
