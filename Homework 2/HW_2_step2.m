% SPP Analysis for Steps 1 and 2
% Define constants and parameters
lambda = 532; % Wavelength in nm
n_glass = 1.68; % Refractive index of glass
n_water = 1.33; % Refractive index of water
d_metal = 40; % Metal thickness in nm
epsilon_metal = -10 + 1i; % Permittivity of silver

% Convert units for tmm.m compatibility
lambda_m = lambda * 1e-9; % Wavelength in meters
d_metal_m = d_metal * 1e-9; % Metal thickness in meters

% Define angular range for incidence
theta = linspace(0, 90, 1000); % Angle of incidence in degrees

% Define biofilm refractive index range
n_f_range = linspace(n_water, 1.7, 50); % From n_water to 1.7

% Preallocate results for Step 2
theta_min_values = zeros(size(n_f_range));
theta_min_points = []; % Initialize list to store theta_min values with n_f

% Loop over biofilm refractive index values
for j = 1:length(n_f_range)
    n_f = n_f_range(j); % Current biofilm refractive index
    
    % Update layer parameters
    n_layers = [sqrt(epsilon_metal), n_f]; % Metal layer + biofilm
    d_layers = [d_metal_m, 100e-9]; % Metal thickness + biofilm thickness (100 nm)
    
    % Preallocate for angles of incidence
    R = zeros(size(theta));
    
    % Loop over angles of incidence
    for i = 1:length(theta)
        % Call tmm.m function
        T_R_A = tmm(lambda_m, theta(i), n_layers, d_layers, n_glass, n_water, 1);
        
        % Extract Reflectance
        R(i) = T_R_A(2);
    end
    
    % Find the angle of minimum reflectance
    [~, min_idx] = min(R);
    theta_min_values(j) = theta(min_idx);
    
    % Store the refractive index and minimum angle as a point
    theta_min_points = [theta_min_points; [n_f, theta(min_idx)]];
end

% Save theta_min_points as a .mat file for Step 3
save('theta_min_points.mat', 'theta_min_points');

% Plot results for Step 2
figure;
plot(n_f_range, theta_min_values, 'b', 'LineWidth', 1.5);
xlabel('Biofilm Refractive Index n_f');
ylabel('Angle of Minimum Reflectance \theta_{dip} (degrees)');
title('Variation of \theta_{dip} with Biofilm Refractive Index');
grid on;

% Check the saved data and output graph
% Load theta_min_points from .mat file
load('theta_min_points.mat');

% Display the first few points
disp('n_f and theta_min values:');
disp(theta_min_points(1:10, :)); % Show first 10 points
