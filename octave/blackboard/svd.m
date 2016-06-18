A=[1, 2, 3; 4, 5, 6];

[U,S,V]=svd(A)

[V,D]=eig((A*A'))

