clear all;
close all;

%rinomina le immagini del dataset, se è già stato fatto serve cambiare la
%cartella di destinazione.
projectdir='dataset';


dinfo = dir( fullfile(projectdir, '*.jpg') );
oldnames = {dinfo.name};
newnames = regexprep(oldnames, '^(.)', '$1_');
for K = 1 : 463
  nome = "image"+K+".jpg";
  movefile( fullfile(projectdir, oldnames{K}), fullfile(projectdir, nome) );
end