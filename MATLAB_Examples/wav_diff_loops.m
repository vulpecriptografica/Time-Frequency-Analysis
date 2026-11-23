%choose a wavelet, compare images w/ different loop #

%DATA
X = imread("/Users/sophievulpe/Desktop/UROP+ Summer 2023/butter.jpg");
%imshow(X);
Y = imresize(X, [1024, 1024]);

%WAVELET COMPRESSION
meth = 'ezw';
nbloop1 = 6;  %number of loops 
nbloop2 = 10;
nbloop3 = 14;
w = 'bior3.3'; %wavelet   

[CR1,BPP1] = wcompress('c',Y,'butter.wtc',meth,'maxloop', nbloop1,'wname', w); 
[CR2, BPP2] = wcompress('c',Y,'buttery.wtc',meth,'maxloop', nbloop2,'wname',w); 
[CR3, BPP3] = wcompress('c',Y,'buttering.wtc',meth,'maxloop', nbloop3,'wname',w); 

%OTHER
compressed_butter_1 = wcompress('u','butter.wtc');
compressed_butter_2 = wcompress('u', 'buttery.wtc');
compressed_butter_3 = wcompress('u', 'buttering.wtc');

colormap(pink(255));

%PLOTTING


%first subplot
subplot(2,2,1); image(Y);
axis square;
title('Original Image')

%second subplot
subplot(2,2,2); image(compressed_butter_1);
axis square;
title('Compressed Image:', nbloop1)
xlabel({['Compression Ratio: ' num2str(CR1,'%1.2f %%')], ...
        ['Bits per pixel: ' num2str(BPP1,'%3.2f')] ...
        ['Steps: ' num2str(nbloop1)]...
        });

%third subplot
subplot(2,2,3); image(compressed_butter_2);
axis square;
title('Compressed Image:', nbloop2)
xlabel({['Compression Ratio: ' num2str(CR2,'%1.2f %%')], ...
        ['Bits per pixel: ' num2str(BPP2,'%3.2f')] ...
        ['Steps: ' num2str(nbloop2)]...
        });

%fourth subplot
subplot(2,2,4); image(compressed_butter_3);
axis square;
title('Compressed Image:', nbloop3)
xlabel({['Compression Ratio: ' num2str(CR3,'%1.2f %%')], ...
        ['Bits per pixel: ' num2str(BPP3,'%3.2f')] ...
        ['Steps: ' num2str(nbloop3)]...
        });
