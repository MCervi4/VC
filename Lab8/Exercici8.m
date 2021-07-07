I = rgb2gray(imread('Joc_de_caracters.jpg'));
BI = I < 128; % lletres estan en negre
%imshow(BI);

CC = bwconncomp(BI);

props = regionprops(CC,'MajorAxisLength','MinorAxisLength', 'Eccentricity','Orientation', 'Circularity', 'Solidity','Extent','MaxFeretProperties', 'MinFeretProperties');

relacio = [props.MinorAxisLength]./[props.MajorAxisLength];
relacio2 = [props.MinFeretDiameter]./[props.MaxFeretDiameter];
absol=abs([props.Orientation]);

X = [props.Eccentricity; relacio; props.Circularity; props.Extent; props.Solidity;absol]';

OUT = {'0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'B' 'C' 'D' 'F' 'G' 'H' 'J' 'K' 'L' 'M' 'N' 'P' 'R' 'S' 'T' 'V' 'W' 'X' 'Y' 'Z'};

Classifier = TreeBagger(100,X,OUT');

I = rgb2gray(imread('matricula-espana.jpg'));
BI = I < 128; % separem el background

%H = histogram(I); plot(H);
BI = I < 50; % separem el background
BI = bwmorph(BI,'majority');
figure;imshow(BI);
CC = bwconncomp(BI);

props = regionprops(CC,'MajorAxisLength','MinorAxisLength', 'Eccentricity','Orientation', 'Circularity','Solidity','Extent','MaxFeretProperties', 'MinFeretProperties');

relacio = [props.MinorAxisLength]./[props.MajorAxisLength];
relacio2 = [props.MinFeretDiameter]./[props.MaxFeretDiameter];
absol=abs([props.Orientation]);
X = [props.Eccentricity; relacio; props.Circularity; props.Extent; props.Solidity;absol]';


[label,score] = predict(Classifier,X);


% mostrem el resultat mes probable
T = table(label,max(score')','VariableNames',{'Label','Score'});
SCORE = sum(max(score'))/7;
accuracity = 2/7;
SCORE
accuracity

