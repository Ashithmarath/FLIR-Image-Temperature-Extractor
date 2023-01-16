function T_matrix = Temperature_Matrix(filename, Thigh,Tlow)
format long g;
format compact;

%===============================================================================
%===============================================================================
% Read in a demo image.
originalRGBImage = imread(filename);

grayImage = min(originalRGBImage, [], 3); % Useful for finding image and color map regions of image.
% Get the dimensions of the image.  numberOfColorChannels should be = 3.
[rows, columns, numberOfColorChannels] = size(originalRGBImage);
% Crop off the surrounding clutter to get the colorbar.
colorBarImage = imcrop(originalRGBImage, [627, 50, 4, rows-100]);
b = colorBarImage(:,:,3);

% Crop off the surrounding clutter to get the RGB image.
rgbImage = imcrop(originalRGBImage, [1, 1, 640, 480]);%[10, 50, 610, 385]); %cols, %rows, %col_no, %row_no

% Get the dimensions of the image.  
% numberOfColorBands should be = 3.
[rows, columns, numberOfColorChannels] = size(rgbImage);

% Get the color map.
storedColorMap = colorBarImage(:,1,:);
% Need to call squeeze to get it from a 3D matrix to a 2-D matrix.
% Also need to divide by 255 since colormap values must be between 0 and 1.
storedColorMap = double(squeeze(storedColorMap)) / 255 ;
% Need to flip up/down because the low rows are the high temperatures, not the low temperatures.
storedColorMap = flipud(storedColorMap);

% Convert from an RGB image to a grayscale, indexed, thermal image.
indexedImage = rgb2ind(rgbImage, storedColorMap);
% Define the temperature at the top end of the scale
% This will probably be the high temperature.
highTemp = Thigh;
% Define the temperature at the dark end of the scale
% This will probably be the low temperature.
lowTemp = Tlow;
% Scale the image so that it's actual temperatures
thermalImage = lowTemp + (highTemp - lowTemp) * mat2gray(indexedImage);
T_matrix = thermalImage;


end