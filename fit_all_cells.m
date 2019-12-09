clear all;
load('non-dividing');
%%binfact and pixelsize should be already saved to the .mat file.


guess=1e-3/(binfact*pixelsize)^2; %in units of binned pixels
avg=0;
for i=1:length(cells)
data=cells{i};
data=bindata(data,binfact);%use pixel binning to correct for oversampling (confocal microscope)

data=data(3:end-2,:)*diag(1./sum(data(3:end-2,:),1));%take off the ends and renormalize

npixels(i)=length(data(:,1));
avg=avg+interp1(([1:npixels(i)]-1)/(npixels(i)-1),data,0:0.02:1);

[d1,results(i,2),d2,results(i,4)]=fitkymo(data,guess); %fit
results(i,1)=d1*(binfact*pixelsize)^2;
results(i,3)=d2*(binfact*pixelsize)^2;


    D_median(i)=median(results(i,3)./data(:,1)/length(data(:,1)));%%median (Fokker Planck) Deff accross each cell
   
    D(:,i)=interp1(([1:npixels(i)]-1)/(npixels(i)-1),results(i,3)./data(:,1)/length(data(:,1)),0:0.02:1); %scaled Deff for all cells
end
avg=avg/length(cells);%average of all scaled cells
avg=avg*diag(1./sum(avg(1:end,:),1));

save('non-dividing','-append','results','avg','D_median','D')

