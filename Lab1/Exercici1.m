% Point cloud creation
x = rand(1,100) + rand();   % 100 punts aleatoris amb un offset també aleatori
y = rand().*x  + rand(1,100)/10; % pendent de valor aleatori i offset també aleatori

figure(1);
scatter(x,y);
axis([0 2 0 1]);

% Cloud point centering
xp = x - mean(x);
yp = y - mean(y);

% Covariance and eigen values
c = cov(xp, yp);
[evectors, evalues] = eig(c);

% Determine which dimension has the major variance  
[val,ind] = max(diag(evalues));

% Extract the angle of the ‘major axis’
theta = -pi/2-atan2(evectors(ind,1),evectors(ind,2)); % heu d’endevinar que cal posar aquí

% Create clockwise rotation matrix
R = [cos(theta) sin(theta); -sin(theta) cos(theta)]; % heu de buscar a internet que cal posar aquí

% Rotate the points 
rp = R * [xp;yp];

% Draw the points
figure(2);
scatter(rp(1,:),rp(2,:));
axis([-1 1 -0.5 0.5]);

