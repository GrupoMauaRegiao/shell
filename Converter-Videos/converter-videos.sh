#!/bin/bash

converterVideo() {
  mkdir FLV;

  for i in $(ls | grep -i '.wmv$\|.mp4$\|.avi$')
  do
    ffmpeg -i $i \
    -f flv \
    -qscale 15 \
    -ar 22050 \
    -ab 96 \
    -s 960x544 \
    FLV/$i.flv;
  done

  clear;

  echo "Vídeo (s) convertido (s) com sucesso.";
}

converterVideo;