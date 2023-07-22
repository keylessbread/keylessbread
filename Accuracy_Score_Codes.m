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

% Training accuracy is the number of times that y is equal to the true target
fprintf (1, 'Training rate %g%%\n', 100* sum(y == ttr )/ Ntr );
% Test accuracy .
Nte = size (Xte , 1);
y = zeros (Nte , 1);
for n = 1: Nte
D0 = (Xte (n ,:)' - xbar0 )' * S0inv * (Xte (n ,:)' - xbar0 );
D1 = (Xte (n ,:)' - xbar1 )' * S1inv * (Xte (n ,:)' - xbar1 );
if D0 < D1
y(n) = 0;
else
y(n) = 1;
end
end
fprintf (1, 'Test rate %g%%\n', 100* sum (y == tte )/ Nte )