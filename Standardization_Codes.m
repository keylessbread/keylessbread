% find its mean and standard
% deviation and thus standardise it.
load tremor % Get the data
% Plot the original data
figure
I0 = find (ttr == 0);
scatter (Xtr (I0 ,1) , Xtr (I0 ,2) , ’ro ’);
hold on
9 I1 = find (ttr == 1);
scatter (Xtr (I1 ,1) , Xtr (I1 ,2) , ’bs ’);
box;
axis equal ;
title (’ Tremor data ’)
% Find the mean and standard deviation . This is most easily
% done with the mean and std Matlab commands , but here it ’s done
% ’by hand ’ for matlab practice .
[N, D] = size (Xtr );
xbar = sum (Xtr )/N;
fprintf (1, ’Mean of original data \n ’)
disp ( xbar )


% Plot the mean of the dataset
plot ( xbar (1) , xbar (2) , ’kx ’, ’LineWidth ’, 2, ’MarkerSize ’, 12)
% Find the means of the classes and plot them
xb = mean (Xtr (I0 ,:));
plot (xb (1) , xb (2) , ’rx ’, ’LineWidth ’, 2, ’MarkerSize ’, 12)
29 xb = mean (Xtr (I1 ,:));
plot (xb (1) , xb (2) , ’bx ’, ’LineWidth ’, 2, ’MarkerSize ’, 12)
print (gcf , ’tremor - original -with - means .eps ’);
sd = (sum (( Xtr - repmat (xbar , N, 1)).^2)/(N -1)).^0.5;
fprintf (1, ’Standard deviation \n ’)
disp (sd)
% Standardise by subtracting the mean and dividing by the
% standard deviation of each column . This can be done in a number
% of ways .
Y = Xtr - repmat (xbar , N, 1); % Subtract the mean
Y = Y./ repmat (sd , N, 1); % Divide by st. dev.
% Plot standardised data
figure
scatter (Y(I0 ,1) , Y(I0 ,2) , ’ro ’);
hold on
scatter (Y(I1 ,1) , Y(I1 ,2) , ’bs ’);
box;
49 axis equal ;
title (’ Standardised tremor data ’)
print (gcf , ’tremor - standardised .eps ’);
% Check the mean and standard deviation
fprintf (1, ’Mean of standardised data \n ’)
disp ( mean (Y));
fprintf (1, ’Standard deviation of standardised data \n ’);
disp (std (Y));

% Calculate the correlation as the covariance of the standardised data
R = cov (Y);
59 fprintf (1, ’ Correlation matrix \n ’)
disp (R)

function [S, SS , SSS ] = covary (X)
% Return the sample covariance matrix for X calculated in three equivalent
% ways
[N, D] = size (X);
% First method , with loops :
xbar = mean (X); % Mean
S = zeros (D, D);
for i = 1:D
for j = 1:i % Covariance is symmetric so only calculate one triangle
for n = 1:N
S(i,j) = S(i,j) + (X(n,i)- xbar (i ))*( X(n,j)- xbar (j));
end
S(j,i) = S(i,j);
end

end
S = S/(N -1);
% Second method , slightly slicker
SS = zeros (D, D);
Y = X - repmat ( mean (X), N, 1); % Mean centre
for i = 1:D
for j = 1:i
SS(i,j) = Y(:,i)’*Y(:,j);
SS(j,i) = SS(i,j);
end
end
SS = SS /(N -1);
% Third method , needs a bit of thinking about
Y = X - repmat ( mean (X), N, 1); % Mean centre
SSS = Y ’*Y/(N -1);

% tremorcorrelation -- find correlations for the tremor data by finding
% the covariance for the standardised covariances
load tremor % Get the data
[N, D] = size (Xtr );
% All the data together
Y = Xtr - repmat ( mean (Xtr ), N, 1); % Subtract mean
Y = Y./ repmat (std (Xtr ), N, 1); % Standardised
S = cov (Y); % Covariance
fprintf (1, 'Overall correlation : %g\n', S (1 ,2));
% Each class by itself
for c = [0, 1]
X = Xtr (ttr == c ,:); % Select the class
n = size (X, 1);
Y = X - repmat ( mean (X), n, 1);
% Subtract mean
Y = Y./ repmat (std(X), n, 1); % Standardised
S = cov (Y); % Covariance
fpriintf (1, 'Correlation for class %d: %g\n', c, S (1 ,2));
end