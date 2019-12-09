clear all;
name='dividing_pole';
load('dividing_pole');

%%
%individual cells
figure(1)
clf;

D_median(D_median==0)=NaN;%remove 1 bad cell for non-dividing cells

violinplot([D_median']);
ylabel('Effective Diffusion constant (\mu m^2/s)')
box on;
ylim([0,2.1e-3])


figure(2)
clf
CI=bootci(1000,@median,D');
%errorbar(0:0.02:1,median(D,2),median(D,2)'-CI(1,:),CI(2,:)-median(D,2)','DisplayName','Non-Dividing')
%errorbar(0:0.02:1,mean(D,2),std(D,0,2)/sqrt(size(D,2)),'DisplayName','Non-dividing')
%errorbar(0:0.02:1,median(D,2),mad(D,0,2)/0.67449/sqrt(size(D,2)),'DisplayName','Dividing')
shadederror(0:0.02:1,median(D,2)',CI(1,:),CI(2,:),name)
legend;
xlabel('Relative Position')
ylabel('Effective diffusion constant (\mu m^2/s)')

%%
%averaged cell

guess=1e-3/(binfact*pixelsize)^2; %in units of binned pixels

data=avg;
[d1,fval1,d2,fval2]=fitkymo(data,guess);
d1*(binfact*pixelsize)^2 %Fickian
fval1
d2*(binfact*pixelsize)^2 %Fokker Planck
fval2

figure(3)
clf
subplot(3,1,1)
imagesc(1:7,[0,1],data)
title('Averaged scaled data')

subplot(3,1,2)
sol=spatialFRAP(data(:,2),d1);
imagesc(1:7,[0,1],[data(:,1),sol])
title('Fickian')

subplot(3,1,3)
sol=spatialFRAP(data(:,2),d2./data(:,1)/length(data(:,1)));
imagesc(1:7,[0,1],[data(:,1),sol])
title('Fokker-Planck')