# Designing Differentially Private Estimators in High Dimensions

MATLAB implementation of the differentially private robust mean estimator for high dimensions.


### Prerequisites

- MATLAB package for [Fast SVD and PCA](https://www.mathworks.com/matlabcentral/fileexchange/47132-fast-svd-and-pca) for eigenvalue computation on larger matrices


### Algorithm Implementation

The `dpCode` directory contains the implementation code of various differentially private mean estimation algorithms.

- `dpFilterGaussianMean.m`: Primary implementation of the novel proposed differentially private algorithm in the paper
- `filterGaussianMean.m`: Implementation of robust mean estimation by filtering taken from the [original authors](https://github.com/hoonose/robust-filter) and described in their paper [Being Robust (in High Dimensions) Can Be Practical](https://arxiv.org/abs/1703.00893) from ICML 2017
- `dpWinsorizedMean.m`: Implementation of the differentially private Widened Winsorized Mean (Algorithm 1) from ["Privacy-preserving Statistical Estimation with Optimal Convergence Rates"](http://www.cse.psu.edu/~ads22/pubs/2011/stoc194-smith.pdf)
- `privateQuantile.m`: Utility function containing the implementation of the `privateQuantile` algorithm (Algorithm 2) from ["Privacy-preserving Statistical Estimation with Optimal Convergence Rates"](http://www.cse.psu.edu/~ads22/pubs/2011/stoc194-smith.pdf)
- `laplaceSample.m`: Utility function that draws a noise sample from the Laplace distribution by inverse CDF sampling

Only the first two files are needed for our algorithm, while the following two are for the DP Winsorized mean reference algorithm from ["Privacy-preserving Statistical Estimation with Optimal Convergence Rates"](http://www.cse.psu.edu/~ads22/pubs/2011/stoc194-smith.pdf). The last file (`laplaceSample.m`) is a utility implementation for the Laplace mechanism used in both algorithms.

### Reproducibility

`compareDPMeanEstimators.m` contains all the evaluation code for reproducing all figures in the paper. `compareDPMeanEstimatorsFunctional.m` contains experimental code on using corruption values that are a function of data set size.

