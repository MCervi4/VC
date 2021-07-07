I = imread('flor.png');

%imshow(I);

%rect = getrect;

HSV = rgb2hsv(I);

[f, c, d] = size(HSV);

H = HSV(:,:,1)*2*pi;

Hx = cos(H);

Hy = sin(H);

S = HSV(:,:,2);

V = HSV(:,:,3);

Hx = reshape(Hx,[f*c,1]);
Hy = reshape(Hy,[f*c,1]);
S = reshape(S,[f*c,1]);
V = reshape(V,[f*c,1]);


O = [Hx Hy S V];
k=20;
C = kmeans(O,k);

%IC = reshape(C,f,c);
%rgb = label2rgb(IC);
%imshow(rgb);
x = [round(f/4), round(f/4)*3, round(f/4)*3, round(f/4)];
y = [round(c/4),round(c/4), round(c/4)*3, round(c/4)*3];
MASK = poly2mask(x,y,f,c);
imshow(MASK);

VEC_H = [C, MASK(:)];

Hist0 = zeros(1,k);
Hist1 = zeros(1,k);

for count = 1:f*c
    pos = VEC_H(count,1);
    res = VEC_H(count,2);
    if res
        Hist1(pos) = Hist1(pos)+ 1;
    else
        Hist0(pos) = Hist0(pos)+ 1;
    end
end

RES = Hist1 > Hist0;

M = zeros(f*c,1);

for count = 1:f*c
    pos = VEC_H(count,1);
    if RES(pos)
        M(count)=1;
    end
end
M = reshape(M,[f,c]);

disk = strel('disk',10);
M = imclose(M,disk);


disk = strel('disk',5);
M2 = imerode(M,disk);

MT = M-M2;

%filt = fspecial('average', 3);
%M = imfilter(M,filt);
%montage({M,M2});
%imshow(MT);

I = imoverlay(I,MT,'red');
%imshow(I);
%montage({I,M});