%% Constants
% Input parameters
lambda_1 = 650e-9; % Wavelength for Task 1 (meters)
lambda_2 = 300e-9; % Wavelength for Task 2 (meters)
theta = 0; % Normal incidence
n_input = 1.0; % Input medium (air)
n_output = 1.45; % Output medium (subcutaneous fat)

% Skin layer parameters
d_layers = [10e-6, 60e-6, 2e-3]; % Thicknesses (meters)
n_layers_650 = [1.5 + 1i*0.003, 1.4 + 1i*0.00001, 1.4 + 1i*0.00001];
n_layers_300 = [1.5 + 1i*0.03, 1.4 + 1i*0.001, 1.4 + 1i*0.006];

%% Task 1: Transmittance, Reflectance, Absorption at 650 nm
[T_R_A_650] = tmm(lambda_1, theta, n_layers_650, d_layers, n_input, n_output, 0);

% Display results
disp('Power Absorbed at 650 nm:');
disp(['Transmittance: ', num2str(T_R_A_650(1))]);
disp(['Reflectance: ', num2str(T_R_A_650(2))]);
disp(['Absorption: ', num2str(T_R_A_650(3))]);

%% Task 2: Transmittance, Reflectance, Absorption at 300 nm
[T_R_A_300] = tmm(lambda_2, theta, n_layers_300, d_layers, n_input, n_output, 0);

% Display results
disp('Power Absorbed at 300 nm:');
disp(['Transmittance: ', num2str(T_R_A_300(1))]);
disp(['Reflectance: ', num2str(T_R_A_300(2))]);
disp(['Absorption: ', num2str(T_R_A_300(3))]);

%% Task 3: Sunscreen Calculations
% Sunscreen parameters
SPF_target = 30; % Target SPF
thickness_sunscreen = 2e-6; % Sunscreen layer thickness (meters)
absorption_sunscreen = 1 - 1 / SPF_target;

% Calculate refractive index imaginary part for sunscreen
imaginary_index_sunscreen = absorption_sunscreen * lambda_2 / (4 * pi * thickness_sunscreen);
n_sunscreen = 1.5 + 1i * imaginary_index_sunscreen;

% Add sunscreen layer to the stack
n_layers_with_sunscreen = [n_sunscreen, n_layers_300];
d_layers_with_sunscreen = [thickness_sunscreen, d_layers];

% Calculate with sunscreen at 300 nm
[T_R_A_sunscreen] = tmm(lambda_2, theta, n_layers_with_sunscreen, d_layers_with_sunscreen, n_input, n_output, 0);

% Display sunscreen results
disp('Sunscreen Effectiveness:');
disp(['Transmittance: ', num2str(T_R_A_sunscreen(1))]);
disp(['Reflectance: ', num2str(T_R_A_sunscreen(2))]);
disp(['Absorption: ', num2str(T_R_A_sunscreen(3))]);

%% Visualization
% Plot absorption results
figure;
bar([T_R_A_650(3), T_R_A_300(3), T_R_A_sunscreen(3)]);
set(gca, 'XTickLabel', {'650 nm', '300 nm', '300 nm with Sunscreen'});
title('Absorption in Skin Layers');
xlabel('Wavelength and Conditions');
ylabel('Absorption (Fraction of Input Power)');
