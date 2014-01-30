#!/bin/bash

edicao=$1;
paginaForaPadrao=$2;

processarArquivo() {
  convert -monitor \
    -crop 0x0+0+0 \
    -gravity Center \
    -density 300 \
    -quality 90 \
    -attenuate 40 \
    -antialias \
    -colorspace RGB \
    -level 0%,100%,1.7 \
    -crop -0-0 \
    -bordercolor white \
    -border 130x130 \
    -resize 1060x1500 $i JPG/$i.jpg;
}

criarJornal() {
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

  if [[ ! $paginaForaPadrao ]]; then
    for i in $(ls *.pdf)
    do
      processarArquivo;
    done
  else
    for i in $(ls *.pdf)
    do
      processarArquivo;
    done

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
      -bordercolor white \
      -border 130x130 \
      -resize 1060x1500 $paginaForaPadrao.pdf JPG/$paginaForaPadrao.pdf.jpg
  fi

  cd JPG;

  for i in $(ls *.jpg)
  do
    convert -monitor \
      -resize 1536x2067\! $i MAIOR-$i.jpg;
  done

  find . -type f ! -name 'MAIOR*' -delete;

  convert -monitor *.jpg "jornal-maua-e-regiao-ed-$edicao.pdf";

  clear;

  echo "Jornal criado com sucesso.";
}

criarJornal;