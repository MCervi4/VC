A = imread('_61A5845.jpg');
B = imread('_61A5855.jpg');
C = imread('_61A5861.jpg');
A = rgb2gray(A);
B = rgb2gray(B);
C = rgb2gray(C);

hv = fspecial('sobel');
hh = hv';

AV = imfilter(double(A),hv);
AH = imfilter(double(A),hh);

BV = imfilter(double(B),hv);
BH = imfilter(double(B),hh);

CV = imfilter(double(C),hv);
CH = imfilter(double(C),hh);

AF = abs(AV)+abs(AH);
BF = abs(BV)+abs(BH);
CF = abs(CV)+abs(CH);

MAXA = max(max(AF));
MAXB = max(max(BF));
MAXC = max(max(CF));

ANorm = AF./MAXA;
BNorm = BF./MAXB;
CNorm = CF./MAXC;



montage({ANorm BNorm CNorm})


