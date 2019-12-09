# SpatialFRAP
Matlab scripts for the FRAP analysis method presented in Szczepaniak et al. (2019)


Requirements:
Matlab with Statistics (mean, median, bootci,..), Image Processing (immse), Global Optimization (patternsearch) and Parallel Computing toolboxes. Tested on Matlab R2018b on Windows 10.

Contents:
*.mat
Matlab data files with fluorescence data, the pixel size and the binning factor to use, as well as the produced results.
dividing.mat divding WT cells
dividing_pole.mat divding WT cells, FRAPed at the pole
dividing_pole_rel.mat divding WT cells, FRAPed at the pole, fitting done using immsre.m and not immse.m
non-dividing.mat non-dividing WT cells
tolB_dividing.mat delta-tolB dividing cells
tolA_dividing.mat delta-tolA/pGFP-tolA(H22A) dividing cells
tolAKO_dividing.mat delta-tolA dividing cells

spatialFRAP.m
Uses Matlab's PDE solver to return a simulated kymorgraph given the intial data and diffusion coefficient, which may vary spatially

fitkymo.m 
Use "patternsearch" from Matlab's optimisation toolbox to find the diffusion coefficient giving the best fit to the data. For comparison, uses the standard Fickian model of diffusion as well as Fokker-Planck diffusion.

fit_all_cells.m
Run fitkymo.m on all cells in a dataset. Also calculated the median Deff for each cell and the average scaled signal from all cells. Saves the results back to the *.mat file

plot_data.m
Plot the results for a single dataset. Also plots the average kymograph and the best fit to the average.

plot_all.mat
Plots the result of all data sets. Uses violinplot by Bastian Bechtold (available under a BSD 3-clause license from https://github.com/bastibe/Violinplot-Matlab). In the paper, we rather used www.estimationstats.com to make swarm and difference plots, as described in the paper.


Helper scripts:
bindata.m
Smoothen the data in column array by place it in bins and taking the mean

immsre.m
The mean square relative error between two matrices (based on Malab's immse.m)

JSdivergence.m
An alternative distance function based on Jensen-Shannon divergence

shadederror.m
Plot error bars as shading

