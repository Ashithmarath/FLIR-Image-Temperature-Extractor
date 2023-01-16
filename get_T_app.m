function [avg_T, sd_T, T] = get_T_app(x, filename,Thigh,Tlow)
originalRGBImage = imread(filename);
%x(1, length(x)+1) = x(1,1);
%x(2, length(x)) = x(2,1);


xv = x(1,:)';
yv = x(2,:)';
[rows, columns, numberOfColorChannels] = size(originalRGBImage);
[x,y] = meshgrid(1:columns, 1:rows);
xq =reshape(x,[],1);
yq = reshape(y,[],1);
[in,on] = inpolygon(xq,yq,xv,yv);

T_matrix = Temperature_Matrix(filename, Thigh,Tlow);
X = xq(in);
Y = yq(in);
idx = sub2ind(size(T_matrix), Y, X);
T = T_matrix(idx);
avg_T = mean(T);
sd_T = std(T);
