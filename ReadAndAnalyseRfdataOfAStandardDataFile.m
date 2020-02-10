%==============================
%读取并分析一个来自标准数据文件的RF数据
%==============================

data=read(rfdata.data,'passive.s2p');
freq=data.Freq;
s_params=extract(data,'S_PARAMETERS',75);
y_params=extract(data,'Y_PARAMETERS');

s11=s_params(1,1,:);
smithplot(s11(:));

f=freq(end);
s=s_params(:,:,end)
y=y_params(:,:,end)

measured_data=read(rfdata.data,'samplebjt2.s2p');
input_pad=rfckt.cascade('Ckts',{rfckt.seriesrlc('L',1e-9),rfckt.shuntrlc('C',100e-15)});
output_pad=rfckt.cascade('Ckts',{rfckt.shuntrlc('C',100e-15),rfckt.seriesrlc('L',1e-9)});

freq=measured_data.Freq;
analyze(input_pad,freq);
analyze(output_pad,freq);

z0=measured_data.Z0;
input_pad_sparam=extract(input_pad.AnalyzedResult,'S_Parameters',z0);
output_pad_sparam=extract(output_pad.AnalyzedResult,'S_Parameters',z0);
de_embedded_sparams=deembedsparams(measured_data.S_Parameters,input_pad_sparam,output_pad_sparam);

de_embedded_data=rfdata.data('Z0',z0,'S_Parameters',de_embedded_sparams,'Freq',freq);

hold off;
h=smith(measured_data,'S11');
set(h,'Color',[1 0 0]);
hold on;
i=smith(de_embedded_data,'S11');
set(i,'Color',[0 0 1],'LineStyle',':');
%l=legend;
legend({'Measured S_{11}','De-embedded S_{11}'});
legend show;

figure; hold off;
h1=smith(measured_data,'S22');
set(h1,'Color',[1 0 0]);
hold on;
i1=smith(de_embedded_data,'S22');
set(i1,'Color',[0 0 1],'LineStyle',':');
legend({'Measured S_{22}','De-embedded S_{22}'});
legend show;

figure; hold off;
h=plot(measured_data,'S21','dB');
set(h,'Color',[1 0 0]);
hold on;
i=plot(de_embedded_data,'S21','dB');
set(i,'Color',[0 0 1],'LineStyle',':');
legend({'Measured S_{21}','De-embedded S_{21}'});
legend show; hold off;