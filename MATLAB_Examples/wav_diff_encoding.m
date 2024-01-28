%Using different encoding methods

%DATA
X = imread("/Users/sophievulpe/Desktop/UROP+ Summer 2023/butter.jpg");
imshow(X);
Y = imresize(X, [1024, 1024]); %Image must have dimensions that are powers of two for wavelet compression algo

%WAVELET COMPRESSION
meth1   = 'ezw';   % Encoding method name, could also use spiht, stw, wdr, etc. 
meth2 = 'wdr';
w = 'bior4.4';     % Wavelet
nbloop = 16;       % Number of loops

[CR1,BPP1] = wcompress('c',Y,'butter.wtc',meth1,'maxloop', nbloop,'wname', w); %Outputs compression ratio and bit per pixel ratio of compressed image and original image
[CR2, BPP2] = wcompress('c',Y,'buttery.wtc',meth2,'maxloop', nbloop,'wname',w); 

%OTHER
compressed_butter_1 = wcompress('u','butter.wtc'); %U
compressed_butter_2 = wcompress('u', 'buttery.wtc');

colormap(pink(255));

%PLOTTING

subplot(1,2,1); image(compressed_butter_1);
axis square;
title('Compressed Image:', meth1)
xlabel({['Compression Ratio: ' num2str(CR1,'%1.2f %%')], ...
        ['Bits per pixel: ' num2str(BPP1,'%3.2f')] ...
        ['Steps: ' num2str(nbloop)]...
        });

subplot(1,2,2); image(compressed_butter_2);
axis square;
title('Compressed Image:', meth2)
xlabel({['Compression Ratio: ' num2str(CR2,'%1.2f %%')], ...
        ['Bits per pixel: ' num2str(BPP2,'%3.2f')] ...
        ['Steps: ' num2str(nbloop)]...
        });
