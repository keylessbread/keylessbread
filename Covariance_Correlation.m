% PooledMahalanobis -- classify the tremor data using minimum Mahalanobis
% distances and pool covariance matrices
%%load tremor % Get the data
% Find the covariances and means for each class
I = find (ttr == 0);
J = find (ttr == 1);
xbar0 = mean (Xtr(I ,:))';
xbar1 = mean (Xtr(J ,:))'; 
% Work out the pooled ( average ) covariance matrix , weighted by the
% number of samples in each class
S0 = cov (Xtr (I ,:));
N0 = length (I);
S1 = cov (Xtr (J ,:));
N1 = length (J);
S = (N0*S0 + N1*S1 )/( N0+N1 ); % Pooled covariance
Sinv = inv (S);
S0inv = Sinv ;
S1inv = Sinv ;