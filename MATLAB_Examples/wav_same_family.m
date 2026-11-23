%comparing wavelets from the same family at the same loop #

%DATA
X = imread("/Users/sophievulpe/Desktop/UROP+ Summer 2023/butter.jpg");
imshow(X);
Y = imresize(X, [1024, 1024]);

%WAVELET COMPRESSION
meth   = 'ezw';   % Encoding method name
% could also use spiht, stw, wdr, etc. 
w1  = 'rbio3.3';  % Wavelet name
w2 = 'rbio6.8';
nbloop = 16;       % Number of loops

[CR1,BPP1] = wcompress('c',Y,'butter.wtc',meth,'maxloop', nbloop,'wname', w1); 
[CR2, BPP2] = wcompress('c',Y,'buttery.wtc',meth,'maxloop', nbloop,'wname',w2); 

%OTHER 
compressed_butter_1 = wcompress('u','butter.wtc');
compressed_butter_2 = wcompress('u', 'buttery.wtc');

colormap(pink(255));


%PLOTTING
subplot(1,2,1); image(compressed_butter_1);
axis square;
title('Compressed Image:', w1)
xlabel({['Compression Ratio: ' num2str(CR1,'%1.2f %%')], ...
        ['Bits per pixel: ' num2str(BPP1,'%3.2f')] ...
        ['Steps: ' num2str(nbloop)]...
        });

subplot(1,2,2); image(compressed_butter_2);
axis square;
title('Compressed Image:', w2)
xlabel({['Compression Ratio: ' num2str(CR2,'%1.2f %%')], ...
        ['Bits per pixel: ' num2str(BPP2,'%3.2f')] ...
        ['Steps: ' num2str(nbloop)]...
        });

%wcompress(compression, file, name of compressed file, coding method, max
%number of loops, wavelet name)
%number of loops is crucial (more loops -> better recovered image, but
%poorer compression)
