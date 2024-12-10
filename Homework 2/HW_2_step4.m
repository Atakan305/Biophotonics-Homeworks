% It is necessary to hold the workspace from Step 3
% Given refractive index accuracy
delta_n_f = 1e-5; % Target accuracy in refractive index (RIU)

% Calculate angular accuracy
delta_theta_min = S * delta_n_f; % Angular accuracy in degrees

% Display the result
disp(['Angular accuracy (\delta\theta_{min}) required: ', num2str(delta_theta_min), ' degrees']);

% Optional: Visualize the impact of accuracy on measurement
figure;
bar(delta_theta_min, 'FaceColor', 'blue');
xlabel('Refractive Index Accuracy (\delta n_f)');
ylabel('Angular Accuracy (\delta\theta_{dip})');
title('Required Angular Accuracy for Given Refractive Index Accuracy');
grid on;
