function [ dpEstMean ] = dpFilterGaussianMean(data, gamma, tau, cher, C, eps)
    estMean = filterGaussianMean(data, gamma, tau, cher, C);
    
    % laplace mechanism
    kappa = gamma / (1 - 2 * gamma) + (sqrt(2) * gamma + sqrt(2 * gamma)) / (1 - 2 * gamma);
    bound = (3 + 2 * sqrt(gamma)) * kappa + 2 * gamma * sqrt(C * log(1 / gamma));
    noise = laplaceSample(2 * bound / eps, length(estMean));
    
    dpEstMean = estMean + noise;