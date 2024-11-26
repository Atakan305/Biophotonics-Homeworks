%% Constants
% Input parameters
lambda_1 = 650e-9; % Wavelength for Task 1 (meters)
lambda_2 = 300e-9; % Wavelength for Task 2 (meters)
I0 = 1; % Irradiance (W/m^2)
surface_area = (5e-3)^2; % Skin surface area (m^2)

% Skin layer thicknesses (meters)
d_stratum = 10e-6;
d_epidermis = 60e-6;
d_dermis = 2e-3;

% Refractive indices at 650 nm
n_stratum_650 = 1.5 + 1i*0.003;
n_epidermis_650 = 1.4 + 1i*0.00001;
n_dermis_650 = 1.4 + 1i*0.00001;

% Refractive indices at 300 nm
n_stratum_300 = 1.5 + 1i*0.03;
n_epidermis_300 = 1.4 + 1i*0.001;
n_dermis_300 = 1.4 + 1i*0.006;

%% Helper Function: Calculate Absorption
function P_abs = calculate_absorption(n, d, lambda, I0, area)
    alpha = 4 * pi * imag(n) / lambda; % Absorption coefficient
    transmission = exp(-alpha * d); % Transmission through layer
    P_abs = I0 * (1 - transmission) * area; % Power absorbed
end

%% Task 1: Power Absorbed at 650 nm
P_abs_stratum_650 = calculate_absorption(n_stratum_650, d_stratum, lambda_1, I0, surface_area);
P_abs_epidermis_650 = calculate_absorption(n_epidermis_650, d_epidermis, lambda_1, I0, surface_area);
P_abs_dermis_650 = calculate_absorption(n_dermis_650, d_dermis, lambda_1, I0, surface_area);

% Display results
disp('Power Absorbed at 650 nm:');
disp(['Stratum Corneum: ', num2str(P_abs_stratum_650), ' W']);
disp(['Epidermis: ', num2str(P_abs_epidermis_650), ' W']);
disp(['Dermis: ', num2str(P_abs_dermis_650), ' W']);

%% Task 2: Power Absorbed at 300 nm
P_abs_stratum_300 = calculate_absorption(n_stratum_300, d_stratum, lambda_2, I0, surface_area);
P_abs_epidermis_300 = calculate_absorption(n_epidermis_300, d_epidermis, lambda_2, I0, surface_area);
P_abs_dermis_300 = calculate_absorption(n_dermis_300, d_dermis, lambda_2, I0, surface_area);

% Display results
disp('Power Absorbed at 300 nm:');
disp(['Stratum Corneum: ', num2str(P_abs_stratum_300), ' W']);
disp(['Epidermis: ', num2str(P_abs_epidermis_300), ' W']);
disp(['Dermis: ', num2str(P_abs_dermis_300), ' W']);

%% Task 3: Sunscreen Calculations
SPF_target = 30; % Target SPF
thickness_OC = 2e-6; % Nominal sunscreen thickness (meters)
molecular_weight_OC = 361.2; % g/mol
density_OC = 1000; % kg/m^3 (assumed to be water)

% Calculate sunscreen properties
absorption_sunscreen = 1 - 1 / SPF_target;
imaginary_index_OC = absorption_sunscreen * lambda_2 / (4 * pi * thickness_OC);
molar_concentration_OC = imaginary_index_OC * density_OC / molecular_weight_OC;

% Display sunscreen parameters
disp('Sunscreen Parameters:');
disp(['Imaginary Part of Refractive Index: ', num2str(imaginary_index_OC)]);
disp(['Molar Concentration of OC: ', num2str(molar_concentration_OC), ' mol/m^3']);

% Fixed Sunscreen Absorption with Complex Refractive Index
n_sunscreen = 1.5 + 1i * imaginary_index_OC; % Full complex index
P_abs_sunscreen_full = calculate_absorption(n_sunscreen, thickness_OC, lambda_2, I0, surface_area);
P_abs_sunscreen_50 = calculate_absorption(n_sunscreen, thickness_OC * 0.5, lambda_2, I0, surface_area);
P_abs_sunscreen_25 = calculate_absorption(n_sunscreen, thickness_OC * 0.25, lambda_2, I0, surface_area);

disp('Power Absorbed in Sunscreen:');
disp(['Full Thickness: ', num2str(P_abs_sunscreen_full), ' W']);
disp(['50% Thickness: ', num2str(P_abs_sunscreen_50), ' W']);
disp(['25% Thickness: ', num2str(P_abs_sunscreen_25), ' W']);

%% Visualization: Absorbed Power in Skin Layers
figure;
bar([P_abs_stratum_650, P_abs_epidermis_650, P_abs_dermis_650; ...
     P_abs_stratum_300, P_abs_epidermis_300, P_abs_dermis_300]);
set(gca, 'XTickLabel', {'650 nm', '300 nm'});
legend('Stratum Corneum', 'Epidermis', 'Dermis');
title('Power Absorbed in Skin Layers at Different Wavelengths');
xlabel('Wavelength');
ylabel('Power Absorbed (W)');

%% Visualization: Sunscreen Effectiveness
figure;
bar([P_abs_sunscreen_full, P_abs_sunscreen_50, P_abs_sunscreen_25]);
set(gca, 'XTickLabel', {'Full Thickness', '50% Thickness', '25% Thickness'});
title('Sunscreen Absorption at Different Application Levels');
xlabel('Sunscreen Thickness');
ylabel('Power Absorbed (W)');
