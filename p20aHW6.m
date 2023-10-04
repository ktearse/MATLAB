% P20A HW6: Erykah Badu image editing
% Author: Katherine Tearse UID 906065514
% Date: 5/14/2023

%% Image 1
clear       % clear previously defined variables from memory
clc         % clear command window
rng shuffle % shuffle random number generator

% Imports image as "erykah" converts image data to double-precision values
erykahRGB = im2double(imread("Erykah-Badu.jpg"));

% Crop image data to right of column 766, convert to RGB array
erykahCrop = erykahRGB(:, 1:766, :);

% Creates grayscale image for background
grayReplaceMask = erykahCrop(:,:,1)>0.63 &erykahCrop(:,:,1)<0.78 & erykahCrop(:,:,2)>0.63&erykahCrop(:,:,2)<0.78 & erykahCrop(:,:,3)>0.63&erykahCrop(:,:,3)<0.78;
grayReplaceMask(126:182, 434:523, 1) = 0;    % fixes the whitespace left by eyes

% Creates image with orange background erykahOnOrange
orangePixel(:,:, 1) = 0.9;
orangePixel(:,:, 2) = 0.5;
orangePixel(:,:, 3) = 0.1;
orangeBackground = orangePixel.*grayReplaceMask;
erykahOnOrange = orangeBackground + erykahCrop.*~grayReplaceMask;

% Creates image with pale blue background erykahOnBlue
bluePixel(:,:, 1) = 0.1;
bluePixel(:,:, 2) = 0.8;
bluePixel(:,:, 3) = 1;
blueBackground = bluePixel.*grayReplaceMask;
erykahOnBlue = blueBackground + erykahCrop.*~grayReplaceMask;

% Creates image with pink background erykahOnPink
pinkPixel(:,:, 1) = 1;
pinkPixel(:,:, 2) = 0.5;
pinkPixel(:,:, 3) = 0.8;
pinkBackground = pinkPixel.*grayReplaceMask;
erykahOnPink = pinkBackground + erykahCrop.*~grayReplaceMask;

% Creates image with pale green backgroun erykahOnGreen
greenPixel(:,:, 1) = 0.6;
greenPixel(:,:, 2) = 1;
greenPixel(:,:, 3) = 0.6;
greenBackground = greenPixel.*grayReplaceMask;
erykahOnGreen= greenBackground + erykahCrop.*~grayReplaceMask;

% Orients each of the four parts of image 1
erykahOnBlue = fliplr(erykahOnBlue);
erykahOnPink = flipud(erykahOnPink);
erykahOnGreen = rot90(erykahOnGreen,2);

% Join the two rows
image1 = cat(2, erykahOnOrange, erykahOnBlue);
image2 = cat(2, erykahOnPink, erykahOnGreen);

% Join the images to create final image 1
erykahMirror = cat(1, image1, image2);

%% Image 2
% Create red-tinted Erykah
erykahRedTint = erykahCrop;
erykahRedTint(:,:, [2 3]) = 0;

% Add noise to red-tinted Erykah
gaussianNoise  = normrnd(0, 0.2, size(erykahRedTint));
erykahRedTintPlusNoise = double(erykahRedTint) + gaussianNoise + erykahRedTint;

% Create gradient background
zeroTo255Vector = uint8( linspace(0, 255, 1000) );
blueGradient(:, :, 2) = repmat(zeroTo255Vector, 766, 1);
blueGradient(:, :, 1) = zeros(766,1000) ; % page for red   channel (values increase from left to right)
blueGradient(:, :, 3) = repmat(zeroTo255Vector, 766, 1);
blueGradient = rot90(blueGradient, 1);
blueGradientBackground = im2double(blueGradient).* grayReplaceMask;

% Create grid and add it to gradient background
gridReplaceMask = repmat([1 0 0 0 0 0 0 0 0 0 0;
                          1 0 0 0 0 0 0 0 0 0 0 ;
                          1 0 0 0 0 0 0 0 0 0 0 ;
                          1 0 0 0 0 0 0 0 0 0 0 ;
                          1 0 0 0 0 0 0 0 0 0 0 ;
                          1 0 0 0 0 0 0 0 0 0 0 ;
                          1 0 0 0 0 0 0 0 0 0 0 ;
                          1 0 0 0 0 0 0 0 0 0 0 ;
                          1 0 0 0 0 0 0 0 0 0 0 ;
                          1 1 1 1 1 1 1 1 1 1 1  ], 100 );
gridReplaceMask = gridReplaceMask(:, 1:766);
blueBackWithBlackGrid = gridReplaceMask.*grayReplaceMask + blueGradientBackground.*~gridReplaceMask;

% Combine parts of image 2 to create Image 2
erykahNoisyOnGradientGrid = blueBackWithBlackGrid + erykahRedTintPlusNoise.*~grayReplaceMask;

%% Display Images with Titles
sgtitle('MODIFIED IMAGES', 'FontSize', 40, 'FontWeight','bold')
figure(1)

subplot(1, 2, 1)
imshow(erykahMirror)
title('Image 1', 'FontSize', 20, 'FontWeight','bold')

subplot(1, 2, 2)
imshow(erykahNoisyOnGradientGrid )
title('Image 2', 'FontSize', 20, 'FontWeight','bold')

%% Save images
imwrite(erykahMirror,'psych20ahw6image1.png')
imwrite(erykahNoisyOnGradientGrid, 'psych20ahw6image2.png')

saveas(gcf, 'psych20ahw6images.pdf', 'pdf')
