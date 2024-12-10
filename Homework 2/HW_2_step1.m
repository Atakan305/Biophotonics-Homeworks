% SPP Analysis for Step 1
% Define constants and parameters
lambda = 532; % Wavelength in nm
n_glass = 1.68; % Refractive index of glass
n_water = 1.33; % Refractive index of water
d_metal = 40; % Metal thickness in nm
epsilon_metal = -10 + 1i; % Permittivity of silver

% Convert units for tmm.m compatibility
lambda_m = lambda * 1e-9; % Wavelength in meters
d_metal_m = d_metal * 1e-9; % Metal thickness in meters

theta = linspace(0, 90, 1000); % Angle of incidence in degrees

% Preallocate arrays
R = zeros(size(theta));
T = zeros(size(theta));
A = zeros(size(theta));

% Layer parameters for tmm.m
n_layers = [sqrt(epsilon_metal)]; % Use square root of permittivity for refractive index
d_layers = d_metal_m; % Only metal layer thickness

% Loop over angles of incidence
for i = 1:length(theta)
    % Call tmm.m function
    T_R_A = tmm(lambda_m, theta(i), n_layers, d_layers, n_glass, n_water, 1);
    
    % Extract Reflectance, Transmittance, and Absorption
    T(i) = T_R_A(1);
    R(i) = T_R_A(2);
    A(i) = T_R_A(3);
    
    % Check energy conservation
    assert(abs(R(i) + T(i) + A(i) - 1) < 1e-6, 'Energy conservation violated at theta = %f', theta(i));
end

% Find the angle of minimum reflectance
[min_R, min_idx] = min(R);
theta_dip = theta(min_idx);

% Plot results
figure;
plot(theta, R, 'r', 'LineWidth', 1.5);
hold on;
plot(theta, T, 'b', 'LineWidth', 1.5);
plot(theta, A, 'g', 'LineWidth', 1.5);
hold off;
xlabel('Angle of Incidence \theta (degrees)');
ylabel('Fraction');
legend('Reflectance', 'Transmittance', 'Absorption');
title('SPP Analysis: Reflectance, Transmittance, Absorption vs \theta');
grid on;

% Display angle of minimum reflectance
disp(['Angle of minimum reflectance (theta_dip): ', num2str(theta_dip), ' degrees']);
