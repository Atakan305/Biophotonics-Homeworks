% Load data from Step 2
load('theta_min_points.mat'); % Load n_f and theta_min pairs from Step 2

% Separate n_f and theta_min values
n_f_values = theta_min_points(:, 1); % Refractive index values
theta_min_values = theta_min_points(:, 2); % Minimum reflectance angles

% Define linear range for analysis
linear_range_indices = find(n_f_values >= 1.33 & n_f_values <= 1.5); % Select n_f range
n_f_linear = n_f_values(linear_range_indices); % Linear n_f range
theta_min_linear = theta_min_values(linear_range_indices); % Corresponding theta_min

% Perform linear regression on the linear range
p = polyfit(n_f_linear, theta_min_linear, 1); % Linear fit (slope and intercept)

% Sensitivity calculation
S = p(1); % Sensitivity in degrees/RIU

% Plot data and linear fit
figure;
plot(n_f_values, theta_min_values, 'b', 'LineWidth', 1.5); % Original data
hold on;
plot(n_f_linear, polyval(p, n_f_linear), 'r--', 'LineWidth', 1.5); % Linear fit
hold off;
xlabel('Biofilm Refractive Index n_f');
ylabel('Angle of Minimum Reflectance \theta_{dip} (degrees)');
title('Sensitivity Analysis: \theta_{dip} vs n_f');
grid on;
legend('Data', 'Linear Fit');

% Display sensitivity
disp(['Sensitivity S = ', num2str(S), ' degrees/RIU']);
