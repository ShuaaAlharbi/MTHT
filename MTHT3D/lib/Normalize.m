function im = Normalize(im)
im = double(im); im = (im - min(im(:))) / (max(im(:)) - min(im(:)));
end