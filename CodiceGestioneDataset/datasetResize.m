%leggo le due liste per avere i nomi delle immagini 
[images, labels] = readlists();
%estraggo il numero di immagini
nimages = numel(images);
%per ogni immagine, la leggo, le cambio la dimensione e la salvo
for n = 1 : nimages
    disp(n);
    im = imread(['dataset/' images{n}]);
    im = myresize(im,1400);
    imwrite(im, images{n});
end