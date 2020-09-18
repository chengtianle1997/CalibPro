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
scatter3(x,y,z);
plot(error);