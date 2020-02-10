%=========================
%���ж���rfckt.amplifier�����ݶ���rfdata.nf
%ʹ�����ݶ�����Ϊ��·���������NoiseData
%������ֵ
%===========================
amp                =rfckt.amplifier; %��������Ĭ������ֵ�ķŴ�����·����
f                      =2.0e9;
nf                    =13.3244;
nfdata             =rfdata.nf('Freq',f,'Data',nf) %ʹ��ָ�����Դ����������ݶ���
set(amp,'NoiseData',nfdata) %�������ݶ�����Ϊ�Ŵ�������NoiseData��ֵ


%============================
%ʹ�����ݶ������õ�·��������ԣ�
%1.����һ����·����
%2.�����������ݶ���
%3.ʹ�����ݶ�����µ�·���������ֵ��
%============================
amp         =rfckt.amplifier %������·����
f               =[2.08 2.10 2.15]*10e9;
y(:,:,1)        =[-.0090-.0104i,.0013+.0018i;-.2947+.2961i,.0252+.0075i];
y(:,:,2)        =[-.0086-.0047i,.0014+.0019i;-.3047+.3083i,.0251+.0086i];
y(:,:,3)        =[-.0051+.0130i,.0017+.0020i;-.3335+.3861i,.0282+.0110i];
netdata     =rfdata.network('Type','Y_PARAMETERS','Freq',f,'Data',y) %�������ݶ��󴢴���������
 f2             =[1.93 2.06 2.08 2.10 2.15 2.30 2.40]*1.0e9;
 nf             =[12.4521 13.2466 13.6853 14.0612 13.4111 12.9499 13.3244];
 nfdata      =rfdata.nf('Freq',f2,'Data',nf) %����һ�����ݶ��󴢴���������ֵ
 ip3data     =rfdata.ip3('Type','OIP3','Freq',2.1e9,'Data',8.45) %����һ�����ݶ���洢������׽�ֹ��
 
 amp.NetworkData=netdata;
 disp('Done')
 amp.NoiseData=nfdata;
 disp('Done')
 amp.NonlinearData=ip3data;
 disp('Done')
 
 amp
 
 %============================
 %��ȡͬ�ᴫ���ߵ��ڵ���뾶���⵼��뾶
 %============================
 h2=rfckt.coaxial;
 ir=get(h2,'InnerRadius')
 or=get(h2,'OuterRadius')
 get(h2) %��ȡ��������ֵ
 ckt=copy(h2);
 analyze(ckt,f);
 ckt.AnalyzedResult
 