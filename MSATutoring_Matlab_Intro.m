% MSA Tutoring Sessions - Week 02 - Matlab
clear all; close all; clc;
% help function
% to terminate (stop execution) press Command + . (iOS) or Ctrl + C (Windows).
% Command (or Ctrl) + i (to organize the script)
% Shift + Enter = Rename shortcut

prompt = 'Do you want to learn a lot today? Answer = Y/N: ';
% If the input is empty, this code assigns a default value, 'N', to str.
answer = input(prompt,'s');
if isempty(answer)
    answer = 'N';
end
while answer == 'N'  % a better option would be to use while answer ~= 'Y'... why?
    msgbox('Wrong answer, but let''s try again...','Warning');
    prompt = ' Do you want to learn a lot today. Answer = Y/N: ';
    answer = input(prompt,'s');
end
msgbox('Well Done! Let''s get started','Success');
disp('You can also use "disp" to display messages to the user!!!')
clear answer % to clear the variable

%% Solving Linear Equations with MATLAB
clear all;
close all;
clc;
% Example 1: You want to solve for x1 and x2 and you have 2 equations as follows:
% 3*x1 - 9*x2 = -42
% 2*x1 + 4*x2 =   2
A = [3 -9; 2 4]
b = [-42; 2]
% to solve you will need X = inv(A)*b 
X = inv(A)*b

% Example 2: You want to solve for x1, x2 and x3 and you have 3 equations as follows:
%   x1 - 2*x2 -  x3 =  6
% 2*x1 + 2*x2 =  x3 +  1
% 2*x3 -    1 =  x1 + x2
clc;
A = [1 -2 -1; 2 2 -1; -1 -1 2]
b = [6; 1; 1]
% to solve you will need X = inv(A)*b 
X = inv(A)*b


%% Basic Multiple Linear Regression Example 
disp ('A student was asked to find the weights of 2 balls A and B using a scale with random measurement errors. He found the following weights')
disp ('Weight of Ball A (measured alone) = 2lbs')
disp ('Weight of Ball B (measured alone) = 3lbs')
disp ('Weight of Balls A + B (measured together) = 4lbs')   

% 2 ways: manually (algebra) and regression function
clear all;
disp ('First Method: by Algebra')
Y = [2 3 4]'  %or equivalently Y = [2;3;4] or Y = transpose([2 3 4])
X = [ 1 0 ; 0 1 ; 1 1]
inv_matrix = inv(X'*X)
beta_lse = inv_matrix * X' * Y
% notice that the symbol * does the matrix multiplication.
% for element-by-element multiplication, you have to use .*  

% Now calculate the MSE (error variance estimate) and Standard Deviation
mse_est = ((Y(1)-beta_lse(1))^2 + (Y(2)-beta_lse(2))^2 + (Y(3)-beta_lse(1)-beta_lse(2))^2)/(3-2)
std_dev = sqrt(mse_est)

% Compute a 90% Confidence Interval for the weights of Ball A 
help tstat
t_stat = tinv(0.95, 1)
beta_a_upper = beta_lse(1) + t_stat * std_dev * sqrt(inv_matrix(1,1))
beta_a_lower = beta_lse(1) - t_stat * std_dev * sqrt(inv_matrix(1,1))

% .... Alternatively, you can find CI's for both Balls (A and B) using matrix
% calculus directly
upper_ci = beta_lse + t_stat * std_dev * sqrt(diag(inv_matrix))
lower_ci = beta_lse - t_stat * std_dev * sqrt(diag(inv_matrix))
%% 
clear all;
disp ('Second Method: by Stats Function')
Y = [2 3 4]';   %or equivalently Y = [2;3;4] or Y = transpose([2 3 4])
X = [ 1 0 ; 0 1 ; 1 1];
[b, bint, r, rint, stats] = regress(Y, X, 0.1) 
help regress
help rcoplot
rcoplot(r, rint)