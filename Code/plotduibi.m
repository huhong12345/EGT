matlab_blue = [0,114,189]/255;
matlab_orange = [217,83,25]/255;
matlab_purple = [126, 47, 142]/255;
matlab_green = [119, 172, 48]/255;
realESS=[1,1,1,1,1,1,1,1;0.76,0.72272,0.71,0.7,0.6918,0.691,0.69,0.689;
    0.232,0.269,0.29,0.296,0.3,0.305,0.31,0.3115;
    0,0,0,0,0,0,0,0];
x=[6:2:20];
plot(x,ESS(1, :),'d--', 'Color', matlab_blue, 'LineWidth', 1.5);
hold on
plot(x,ESS(2, :),'d--', 'Color', matlab_orange, 'LineWidth', 1.5);
plot(x,ESS(3, :),'d--', 'Color', matlab_purple, 'LineWidth', 1.5);
plot(x,ESS(4, :),'d--', 'Color', matlab_green, 'LineWidth', 1.5);

plot(x,realESS(1, :),'x--', 'Color', matlab_green, 'LineWidth', 1.5);
plot(x,realESS(2, :),'x--', 'Color', matlab_purple, 'LineWidth', 1.5);
plot(x,realESS(3, :),'x--', 'Color', matlab_orange, 'LineWidth', 1.5);
plot(x,realESS(4, :),'x--', 'Color', matlab_blue, 'LineWidth', 1.5);