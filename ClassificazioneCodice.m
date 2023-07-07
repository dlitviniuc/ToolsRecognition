close all;
clear all;
%leggo un'immagine rgb
im = imread("risorse/foto/im_group3.jpg");

%mostro l'immagine binarizzata

figure(1),
subplot(1,3,1),
imshow(Binarizzazione(im)),
title("Immagine Binarizzata");

%mostro l'immagine binarizzata con oggetti piccoli rimossi

subplot(1,3,2),
imshow(removeSmall(im)),
title("Immagine Binarizzata senza oggetti piccoli");

%mostro l'immagine classificata

subplot(1,3,3),
imshow(SegmentazioneClassifica(im)),
title("Immagine Classificata");