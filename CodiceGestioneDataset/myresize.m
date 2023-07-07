function out = myresize (im,s)
    [n,m] = size(im);
    scale = s/n;
    out = imresize(im, scale);
end