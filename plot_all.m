clear all;

z_d=load('dividing');
z_nd=load('non-dividing');
z_B=load('tolB_dividing');
z_A=load('tolA_dividing');
z_AKO=load('tolAKO_dividing');
%%
figure(5)
clf;

violinplot([z_d.D_median' z_nd.D_median' z_B.D_median' z_AKO.D_median' z_A.D_median']);
ylabel('Effective Diffusion constant (\mu m^2/s)')
box on;
set(gca, 'xtick', 1:5, 'xticklabels', {'dividing','non-dividing','tolB','tolA KO', 'tolA (H22A)'});
ylim([0,2.1e-3])


figure(7)
clf
D=z_nd.D;
CI=bootci(1000,@nanmedian,D');
shadederror(0:0.02:1,nanmedian(D,2)',CI(1,:),CI(2,:),'Non-Dividing')

hold on
D=z_d.D;
CI=bootci(1000,@median,D');
shadederror(0:0.02:1,median(D,2)',CI(1,:),CI(2,:),'Dividing')

D=z_B.D;
CI=bootci(1000,@median,D');
shadederror(0:0.02:1,median(D,2)',CI(1,:),CI(2,:),'tolB')

D=z_AKO.D;
CI=bootci(1000,@median,D');
shadederror(0:0.02:1,median(D,2)',CI(1,:),CI(2,:),'tolA')

D=z_A.D;
CI=bootci(1000,@median,D');
shadederror(0:0.02:1,median(D,2)',CI(1,:),CI(2,:),'tolA(H22A)')

hold off
legend;
xlabel('Relative Position')
ylabel('Effective diffusion constant (\mu m^2/s)')
