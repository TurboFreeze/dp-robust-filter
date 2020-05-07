% from "Privacy-preserving Statistical Estimation with Optimal Convergence
% Rates"
% implementation of DP Winsorized Mean

function [ dpMean ] = dpWinsorizedMean(Z, epsilon, Lambda)
    rad = length(Z)^(1/3 + 1/10);
    
    % estimating equantiles with exponential mechanism
    ahat = privateQuantile(Z, 1 / 4, epsilon / 4, Lambda);
    bhat = privateQuantile(Z, 3 / 4, epsilon / 4, Lambda);
    
    mucrude = (ahat + bhat) / 2;
    iqrcrude = abs(bhat - ahat);
    
    upper = mucrude + 4 * rad * iqrcrude;
    lower = mucrude - 4 * rad * iqrcrude;
    
    % winsorize using found bounds
    winsorized = Z;
    winsorized(winsorized > upper) = upper;
    winsorized(winsorized < lower) = lower;
    winsorizedMean = mean(winsorized);
    
    % make differentially private with laplace mechanism
    noise = laplaceSample(abs(upper - lower) / (2 * epsilon * length(Z)), 1);
    
    dpMean = winsorizedMean + noise;