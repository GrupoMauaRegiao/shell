#!/bin/bash

edicao=$1;

upload_issuu_revista() {
  api_key=`awk -F", " '{print $1}' ../config_revista`;
  api_sec=`awk -F", " '{print $2}' ../config_revista`;
  dir=`pwd`;
  nome_arquivo=`basename revista-maua-e-regiao-ed-$edicao.pdf`;
  caminho_completo="$dir/$nome_arquivo";
  title="Revista Mauá e Região #$edicao";

  criar_hash_md5() {
    string="${api_sec}actionissuu.document.uploadapiKey${api_key}name${nome_arquivo}title${title}";
    md5_hash=`echo -n $string | md5sum | awk '{print $1}'`;
  }
  criar_hash_md5;

  {
    # Faz o envio do arquivo
    curl -v \
      -# \
      -F "file=@\"$caminho_completo\"; filename=\"$nome_arquivo\"" \
      -F "action=issuu.document.upload" \
      -F "apiKey=$api_key" \
      -F "name=$nome_arquivo" \
      -F "title=$title" \
      -F "signature=$md5_hash" \
      http://upload.issuu.com/1_0 > log;

      # Verifica se no arquivo `log` o status é "ok"
      if [[ `cat log | grep ok` ]]; then
        echo "Enviado com sucesso!";
      else
        echo "Falha ao enviar!";
        cat log;
      fi
  } || {
    echo "Falha ao enviar!";
  }
}

criar_revista() {
  # Remove espaços dos nomes dos arquivos
  for i in *.pdf
  do
    {
      mv -v "$i" `echo $i | tr ' ' '-'` 2>/dev/null;
    } || {
      echo "'$i' não é necessário renomear.";
    }
  done

  mkdir -v JPG;

  for i in $(ls *.pdf)
  do
    convert -monitor \
      -verbose \
      -crop 0x0+150+150 \
      -gravity Center \
      -density 300 \
      -quality 90 \
      -attenuate 40 \
      -antialias \
      -colorspace RGB \
      -level 0%,100%,2.0 \
      -crop -75-75 \
      -resize 1060x1500 $i \
      -bordercolor white \
      -border 0 JPG/$i.jpg;
  done

  cd JPG;

  for i in $(ls *.jpg)
  do
    convert -monitor \
      -verbose \
      -resize 1536x2067\! $i MAIOR-$i.jpg;
  done

  find . -type f ! -name 'MAIOR*' -delete;

  convert -monitor \
    -verbose \
    *.jpg "revista-maua-e-regiao-ed-$edicao.pdf";

  upload_issuu_revista;
}
criar_revista;
