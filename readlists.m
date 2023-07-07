function [images,labels]=readlists()
  f=fopen('risorse/images.list');
  z = textscan(f,'%s');
  fclose(f);
  images = z{:}; 

  f=fopen('risorse/labels.list');
  l = textscan(f,'%s');
  labels = l{:};
  fclose(f);
end
