% MSA Tutoring Sessions - Week 02 - Matlab
clear all; close all; clc;
% help function
% to terminate (stop execution) press Command + . (iOS) or Ctrl + C (Windows).
% Command (or Ctrl) + i (to organize the script)
% Shift + Enter = Rename shortcut
%% Linear Optimization with linprog example
clear all;
close all;
clc;
%Draw the feasible set of the LO program, find the optimal solution and
%optimal value to the problem.
%max x2
%s.t.
%   x1 - 2*x2 <= 0
% 2*x1 - 3*x2 <= 2
%   x1 -   x2 <= 3
%  -x1 + 2*x2 <= 2
%-2*x1 +   x2 <= 0

%help linprog

% First: convert to a minimization problem
% x = linprog(f,A,b,Aeq,beq,lb,ub)
% f is the vector with coefficients of the objetive function 
% A is the matrix of coeff. of constraints (LHS) which are <=
% b is the matrix of the values on the RHS for the A constraints
% Aeq is the matrix of coeff. of contrainsts (LHS) which are =
% beq is the matrix of the values on the RHS for the Aeq constraints
% default domain for any variable in Matlab = [-inf, +inf]
% lb = lower bound for the domain of variables
% ub = upper bound for the domain of variables
% [X, Z] = output for coeff. is X and for optimal sol. is Z
f = [0 -1];
A = [1 -2; 2 -3; 1 -1; -1 2; -2 1];
b = [0 2 3 2 0];
Aeq = []; % no equality constraints, empty matrix
beq = [];
lb = [0 0];
ub = [];
[X, Z] = linprog(f,A,b,Aeq,beq,lb,ub)
% we converted from max problem to min problem, so we multiply Z by (-1)
fprintf('The optimal solution is x1 = %.0f  and x2 = %.0f and the opt value is %.0f .\n',X(1), X(2), -Z)


% Now let's plot the feasible region
% However, we're gonna learn how plotting works in Matlab first!!!! 
% For example, if I have y = x^2, I cannot plot like this... why?
% x is not a symbolic variable, it's a vector!!! So when I square I square
% each element in the vector... what I need to do is: y = x.^2 (element-wise)
clc; clear all; close all;
disp('Remember: Matlab just plot data, NOT symbolic elements (use . before operations)')
x= linspace(-2,2); %creates a vector with 100 points between -2 and 2
y = x.^2
plot(x,y)
hold on
z = sin(x)
plot(x,z)
hold off
figure
y = x.^3
plot(x,y)

disp('Let''s continue our LO example and plot the inequality constraints contours')
clc; clear all; close all;
x1=-10:1:10;
x2=-10:1:10;
% x1 and x2 are vectors filled with numbers starting at -10 and ending at 10
% with values at intervals of 0.1
[X1 X2] = meshgrid(x1,x2); % generates matrices X1 and X2 corresponding vectors x1 and x2
%or simply [X1 X2]=meshgrid(-10:1:10,-10:1:10); 
f1 = X2; % the objecive function is evaluated over the entire mesh
ineq1 = X1 - 2*X2; % the inequality g1 is evaluated over the mesh
ineq2 = 2*X1 - 3*X2;
ineq3 = X1 - X2;
ineq4 = -X1 + 2*X2;
ineq5 = -2*X1 + X2;
[C1,h1] = contour(x1,x2,ineq1,[0,0],'r-','LineWidth',2);
clabel(C1,h1,'FontSize',15,'Color','red');
hold on
[C2,h2] = contour(x1,x2,ineq2,[2,2],'m-','LineWidth',2);
clabel(C2,h2,'FontSize',15,'Color','red');
% NOTE: You may define ineq2 as:
%          ineq2 = 2*X1 - 3*X2 - 2
%       and plot the zero-valued contour as:
%          [C2,h2] = contour(x1,x2,ineq2,[0,0],'m-');
%          clabel(C2,h2);
[C3,h3] = contour(x1,x2,ineq3,[3,3],'b-','LineWidth',2);
clabel(C3,h3,'FontSize',15,'Color','red');
[C4,h4] = contour(x1,x2,ineq4,[2,2],'k-','LineWidth',2);
clabel(C4,h4,'FontSize',15,'Color','red');
[C5,h5] = contour(x1,x2,ineq5,[0,0],'y-','LineWidth',2);
clabel(C5,h5,'FontSize',15,'Color','red');
[C,h] = contour(x1,x2,f1,'g-','LineWidth',2);
clabel(C,h,'FontSize',15,'Color','red'); % obj fct contours are plotted GREEN
xlabel(' x1 values','FontName','times','FontSize',12,'FontWeight','bold');
% label for x-axes
ylabel(' x2 values','FontName','times','FontSize',12,'FontWeight','bold');
% label for y-axes
grid
hold off
%ineq1 = x1 - 2*x2 <= 0; % Get True where condition aplies, false where not.
% Get boundaries of the condition
%bound1 = 2*x2(1,:);

%% Image Processing using PCA
clc
clear all
load solar_img.mat
figure; imagesc(solar_img, [0, 5e3]);
axis image;axis off;colormap(hot(512));
title('Original')
test = solar_img;

% break into patches of size 8 by 8
patch = zeros(64,29*36);
% 64 = 8x8
% 232 / 8 = 29
% 288 / 8 = 36

for ii = 1:29
    for jj = 1:36
        tmp = test((ii-1)*8+1:ii*8, (jj-1)*8+1:jj*8);
        patch(:,(ii-1)*36+jj) = tmp(:);
    end
end
% find principle components
% Principal components analysis constructs independent new 
% variables which are linear combinations of the original variables.
[u, d, v] = svd(patch); %singular-value decomposition is a generalization of eigenvalue decomposition
%(U, Sigma, V)= U mxm is the unitary matrix, Sigma mxn is the rectangular diagonal
%matrix and V is nxn unitary matrix
d_diag = diag(d);

% use the first 10 componets to approximate the image
rank = 10;
approx = u(:,1:rank)*diag(d_diag(1:rank))*v(:,1:rank)';

% get back original image
recov_img = zeros(232,288);
for ii = 1:29
    for jj = 1:36
        recov_img((ii-1)*8+1:ii*8, (jj-1)*8+1:jj*8) = ...
            reshape(approx(:,(ii-1)*36+jj),8,8);
    end
end

figure; 
imagesc(recov_img,[0,5e3]); 
axis image;axis off;colormap(hot(512));
title('10 components')


% use the first 5 componets to approximate the image
rank = 5;
approx = u(:,1:rank)*diag(d_diag(1:rank))*v(:,1:rank)';

% get back original image
recov_img = zeros(232,288);
for ii = 1:29
    for jj = 1:36
        recov_img((ii-1)*8+1:ii*8, (jj-1)*8+1:jj*8) = ...
            reshape(approx(:,(ii-1)*36+jj),8,8);
    end
end

figure; 
imagesc(recov_img,[0,5e3]); 
axis image;axis off;colormap(hot(512));
title('5 components')

% use the first 1 componets to approximate the image
rank = 1;
approx = u(:,1:rank)*diag(d_diag(1:rank))*v(:,1:rank)';

% get back original image
recov_img = zeros(232,288);
for ii = 1:29
    for jj = 1:36
        recov_img((ii-1)*8+1:ii*8, (jj-1)*8+1:jj*8) = ...
            reshape(approx(:,(ii-1)*36+jj),8,8);
    end
end

figure; 
imagesc(recov_img,[0,5e3]); 
axis image;axis off;colormap(hot(512));
title('1 components')



