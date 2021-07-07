A = double(imread('_MG_7735.JPG'))/255;
B = double(imread('_MG_7737.JPG')) /255;


Bd = imtranslate(B,[20, -20]);

Am = (A+Bd)/2; % imatge millorada
Am = imadjust(Am,[0 0 0; 1 1 1],[]);
imshow(Am);
%montage ({A,Am});

