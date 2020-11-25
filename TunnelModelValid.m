x = data(:,1);
y = data(:,2);
z = data(:,3);
N = length(x);
%[R,A,B]=circ(x,y,N);
[A,B,R,a] = circfit(x,y);
error = zeros(N,1);
for i = 1:N
    rc = sqrt((x(i) - A)^2 + (y(i) - B)^2);
    error(i) = (rc - R)*1000;
end
<<<<<<< HEAD
=======
scatter3(x,y,z);
>>>>>>> d8176e473c867c79c0086fe774bdd6465b2d1fc7
plot(error);