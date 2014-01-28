#!/bin/bash

edicao=$1;

criarRevista() {
  # Remove espaços dos nomes dos arquivos
  for i in *.pdf
  do
    {
      mv "$i" `echo $i | tr ' ' '-'`;
    } || {
      echo "'$i' não é necessário renomear.";
    }
  done

  mkdir JPG;

  for i in $(ls *.pdf)
  do
    convert -monitor \
      -crop 0x0+150+150 \
      -gravity Center \
      -density 300 \
      -quality 90 \
      -attenuate 40 \
      -antialias \
      -colorspace RGB \
      -level 0%,100%,1.7 \
      -crop -75-75 \
      -resize 1060x1500 $i \
      -bordercolor white \
      -border 0 JPG/$i.jpg;
  done

  cd JPG;

  for i in $(ls *.jpg)
  do
    convert -monitor \
      -resize 1536x2067\! $i MAIOR-$i.jpg;
  done

  find . -type f ! -name 'MAIOR*' -delete

  convert -monitor *.jpg "revista-maua-e-regiao-ed-$edicao.pdf";

  clear;

  echo "Revista criada com sucesso.";
}

criarRevista;