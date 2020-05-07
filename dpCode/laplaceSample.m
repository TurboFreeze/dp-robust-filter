function [ lap ] = laplaceSample(scale, num)
    % Laplace noise sampling by inverse CDF
    mu = 0;
    draw = rand(num, 1) - 0.5;
    lap = mu - (scale * sign(draw)).*log(1 - 2 * abs(draw));