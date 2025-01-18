clc; clear; close all;

%% Question 6

% Define symbolic variables
syms a b mu1 mu2 X nu real
syms theta1 theta2 real

% Define the matrices M and K
M = eye(2);
K = [a*mu1/X^2 + 1, -b*mu1/X^2; -a*mu2/X^2, b*mu2/X^2 + nu];

% Solve the eigenvalue problem
[eigenvectors, eigenvalues] = eig(K);

% Display the natural frequencies and modal vectors
natural_frequencies = sqrt(diag(eigenvalues));
modal_vectors = eigenvectors;

disp('Natural Frequencies:');
disp(natural_frequencies);
disp('Modal Vectors:');
disp(modal_vectors);

%% Question 7

% Find the modal mass and modal stiffness matrices
modal_mass = eigenvectors' * M * eigenvectors;
modal_stiffness = eigenvectors' * K * eigenvectors;

disp('Modal Mass Matrix:');
disp(modal_mass);
disp('Modal Stiffness Matrix:');
disp(modal_stiffness);

% Find the normalized modal vector matrix
normalized_modal_vectors = eigenvectors * diag(1./sqrt(diag(modal_mass)));

disp('Normalized Modal Vectors:');
disp(normalized_modal_vectors);