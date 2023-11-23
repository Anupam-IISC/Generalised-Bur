function [black,white,height,width] = map_definition()
RGB = imread('D:\OneDrive - Indian Institute of Science\SEM II\Motion planning\Project\on image\im2.png');
I = rgb2gray(RGB);
BW = imbinarize(I);
% imshow(BW)
[height,width] =size(BW);

% Find the linear indices of the non-zero pixels
idx1 = find(BW == 1);
idx0 = find(BW == 0);

sub1 = zeros(length(idx1), 2);
sub0 = zeros(length(idx0), 2);

% Convert the linear indices to subscript indices
[sub1(:,1), sub1(:,2)] = ind2sub(size(BW), idx1);
[sub0(:,1), sub0(:,2)] = ind2sub(size(BW), idx0);

% Get the row and column indices of the pixels
[row1, col1] = deal(sub1(:,1), sub1(:,2));
[row0, col0] = deal(sub0(:,1), sub0(:,2));

% Display the binary image
imshow(BW)
impixelinfo()

black =[row0 col0];
white =[row1,col1];
end
% % Highlight the pixels with value 1 in red
% hold on
% plot(col1, row1, 'r.', 'MarkerSize', 0.0001)
% 
% % Highlight the pixels with value 0 in blue
% plot(col0, row0, 'b.', 'MarkerSize', 0.0001)
% 
% % Add a legend
% legend('Pixels with value 1', 'Pixels with value 0')
