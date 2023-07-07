close all;
clear all;
%salva in un file images.list i nomi delle immagini, in questo caso essendo
%sempre imageN.jpg non leggo i nomi dalla cartella dataset
file = fopen("images.list", "w");
for i=1:463
    nome = "image"+i+".jpg\n";
    fprintf(file, nome);
end