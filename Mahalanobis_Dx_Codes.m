% Mahalanobis -- classify the data using minimum Mahalanobis
% distances
%load tremor % Get the data
% Find the covariances and means for each class
I = find (ttr == 0);
J = find (ttr == 1);
xbar0 = mean (Xtr(I ,:)) ;
xbar1 = mean (Xtr(J ,:)) ;
S0inv = inv (cov (Xtr(I ,:))); % Inverse covariance for class 0
S1inv = inv (cov (Xtr(J ,:))); % Inverse covariance for class 1
N = 100; % Number of grid points in x direction
M = 100; % Number of grid points in y direction
x = linspace ( -0.5 , 1.5 , N); % Vector of x coordinates to use

y = linspace ( -1.0 , 1.5 , M); % Vector of y coordinates to use
D = zeros (M, N); % Space for the distances
K = zeros (M, N); % Space for the assigned class 20
for nx = 1:N
for my = 1:M
xy = [x(nx); y(my)]; % Coordinate of a point
D0 = (xy - xbar0 )' * S0inv * (xy - xbar0 ); % Distance to centre of class 0
D1 = (xy - xbar1 )' * S1inv * (xy - xbar1 ); % and class 1
if (D0 < D1)
D(my , nx) = abs(D0(1,2)-D0(2,1));
K(my , nx) = 0; % xy would be classified as class 0
else
D(my , nx) = abs(D1(1,2)-D1(2,1));
K(my , nx) = 1;
end
end
end
% Plot the distances
figure
D = sqrt (D);
h = pcolor (x, y, D); % False colour rendition of D
colormap (jet );
hold on;
set(h, 'EdgeColor', 'none ') % Get rid of lines around each element of D
axis equal % Make x and y units equal
axis tight
colorbar
scatter (Xtr (I ,1) , Xtr (I ,2) , 'ro ');
scatter (Xtr (J ,1) , Xtr (J ,2) , 'k^ ');
scatter ( xbar0 (1) , xbar0 (2) , 60, 'ro', 'filled') % Class means
scatter ( xbar1 (1) , xbar1 (2) , 60, 'k^', 'filled')
contour (x, y, K, [0.5 , 0.5] , 'g', 'LineWidth', 2); % Decision boundary
print (gcf , 'mahalanobis - dist .eps')

% Plot the decision regions
figure
h = pcolor (x, y, K);
set(h, 'EdgeColor', 'none ')
colormap ( gray )
axis equal
axis tight
hold on;
scatter (Xtr (I ,1) , Xtr (I ,2) , 'ro');
scatter (Xtr (J ,1) , Xtr (J ,2) , 'b^ ');
scatter ( xbar0 (1) , xbar0 (2) , 60, 'ro', 'filled') % Class means
scatter ( xbar1 (1) , xbar1 (2) , 60, 'b^', 'filled')
print (gcf , 'mahalanobis - decision .eps')

% Work out the training and test rates . The idea here is to classify
% each of either the training or test data according to the minimum
% Mahalanobis distance computed from the training data .
Ntr = size (Xtr , 1);
y = zeros (Ntr , 1);
for n = 1: Ntr
D0 = (Xtr (n ,:)'  - xbar0 )' * S0inv * (Xtr (n ,:)' - xbar0 );
D1 = (Xtr (n ,:)' - xbar1 )' * S1inv * (Xtr (n ,:)' - xbar1 );
if D0 < D1
y(n) = 0;
else
y(n) = 1;
end
end

