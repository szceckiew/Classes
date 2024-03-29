
clear all; close all;

load('babia_gora.dat'); X=babia_gora;
figure; grid; plot3( X(:,1), X(:,2), X(:,3), 'b.' ); pause
x = X(:,1); y = X(:,2); z = X(:,3);

half_x = X(1:2:121,1); half_y = X(1:2:121,2); half_z = X(1:2:121,3);
%Wzięcie połowy punktów góry.
Missing_X = X(2:2:120,:);

xvar = min(x) : (max(x)-min(x))/200 : max(x);
yvar = min(y) : (max(y)-min(y))/200 : max(y);
[Xi,Yi] = meshgrid( xvar, yvar ); % siatka interpolacji xi, yi
outcub = griddata( x, y, z, Xi,Yi, 'cubic' );
outv4 = griddata( x, y, z, Xi,Yi, 'v4' );
figure; surf( outcub,LineStyle=":", LineWidth=0.1); axis vis3d; pause %rysunek1
figure; surf( outv4,LineStyle=":", LineWidth=0.1); axis vis3d; pause %rysunek2
half_x_var = min(half_x) : (max(half_x)-min(half_x))/200 :max(half_x); %Wychodzi na to samo co xvar
half_y_var = min(half_y) : (max(half_y)-min(half_y))/200 :max(half_y); %Wychodzi na to samo co yvar
[half_Xi,half_Yi] = meshgrid(half_x_var, half_y_var);
%Interpolacjalinear======================================================
half_out_cubic = griddata(half_x, half_y, half_z, half_Xi, half_Yi,'cubic');
surf( half_out_cubic,LineStyle=":", LineWidth=0.1); axis vis3d;
half_out_v4 = griddata(half_x, half_y, half_z, half_Xi, half_Yi,'v4');
surf( half_out_v4,LineStyle=":", LineWidth=0.1); axis vis3d;
%Sumowanie wartości błędówbezwzględnych.=================================

[M,N] = size(Missing_X);
rounded_xvar = round(xvar,4);
rounded_yvar = round(yvar,4);

sum_cub=0;
for i = 1:M
    x_var_index = find(rounded_xvar == Missing_X(i,1));
    y_var_index = find(rounded_yvar == Missing_X(i,2));
    sum_cub = sum_cub + abs(half_out_cubic(y_var_index,x_var_index)-outcub(y_var_index,x_var_index));
end
sum_cub,
%Sumowanie błędów z uwzględnienieznaku.=================================
sum_v4 = 0;
for i = 1:M
    x_var_index = find(rounded_xvar == Missing_X(i,1));
    y_var_index = find(rounded_yvar == Missing_X(i,2));
    sum_v4 = sum_v4 +abs(half_out_v4(y_var_index,x_var_index)-outv4(y_var_index,x_var_index));
end
sum_v4,

pause