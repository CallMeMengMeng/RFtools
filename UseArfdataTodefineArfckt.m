%=========================
%设有对象rfckt.amplifier和数据对象rfdata.nf
%使用数据对象作为电路对象的属性NoiseData
%的属性值
%===========================
amp                =rfckt.amplifier; %创建具有默认属性值的放大器电路对象
f                      =2.0e9;
nf                    =13.3244;
nfdata             =rfdata.nf('Freq',f,'Data',nf) %使用指定属性创建噪声数据对象
set(amp,'NoiseData',nfdata) %噪声数据对象作为放大器属性NoiseData的值


%============================
%使用数据对象设置电路对象的属性：
%1.创建一个电路对象；
%2.创建三个数据对象；
%3.使用数据对象更新电路对象的属性值。
%============================
amp         =rfckt.amplifier %创建电路对象
f               =[2.08 2.10 2.15]*10e9;
y(:,:,1)        =[-.0090-.0104i,.0013+.0018i;-.2947+.2961i,.0252+.0075i];
y(:,:,2)        =[-.0086-.0047i,.0014+.0019i;-.3047+.3083i,.0251+.0086i];
y(:,:,3)        =[-.0051+.0130i,.0017+.0020i;-.3335+.3861i,.0282+.0110i];
netdata     =rfdata.network('Type','Y_PARAMETERS','Freq',f,'Data',y) %创建数据对象储存网络数据
 f2             =[1.93 2.06 2.08 2.10 2.15 2.30 2.40]*1.0e9;
 nf             =[12.4521 13.2466 13.6853 14.0612 13.4111 12.9499 13.3244];
 nfdata      =rfdata.nf('Freq',f2,'Data',nf) %创建一个数据对象储存噪声参数值
 ip3data     =rfdata.ip3('Type','OIP3','Freq',2.1e9,'Data',8.45) %创建一个数据对象存储输出三阶截止点
 
 amp.NetworkData=netdata;
 disp('Done')
 amp.NoiseData=nfdata;
 disp('Done')
 amp.NonlinearData=ip3data;
 disp('Done')
 
 amp
 
 %============================
 %获取同轴传输线的内导体半径和外导体半径
 %============================
 h2=rfckt.coaxial;
 ir=get(h2,'InnerRadius')
 or=get(h2,'OuterRadius')
 get(h2) %获取所有属性值
 ckt=copy(h2);
 analyze(ckt,f);
 ckt.AnalyzedResult
 