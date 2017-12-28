function showImageInAxe(axe, img, imgWidth, imgHeight)
% resize before showing
img=imgResize(img, imgWidth, imgHeight);
% show axe
axe.Visible = 'on';
% show image
axes(axe);
tag = get(axe,'Tag');
imshow(img);
set(axe,'Tag', tag);
end

