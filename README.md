shell
=====

ShellScripts que utilizamos em nossos projetos.

## Lista de arquivos e como utilizar:

> Executar todos na pasta onde os PDFs (CMYK) individuais estão contidos.

---

* **revista.sh** e **config_revista**

Cria versão em PDF (RGB) da revista baseado em arquivos PDF (CMYK) individuais e publica arquivo processado no perfil do [Issuu](http://issuu.com) correspondente aos *tokens* (API token e API secret) fornecidos no arquivo de configuração.

> A publicação não será publicada com uma *descrição*. Se desejar inserí-la, entre em sua conta no Issuu e edite a publicação manualmente.


[revista.sh](https://raw2.github.com/GrupoMauaRegiao/shell/master/revista.sh)

```

./revista.sh numero_edicao

```

[config_revista](https://raw2.github.com/GrupoMauaRegiao/shell/master/config_revista)

```

api_token, api_secret

```
---


* **jornal.sh** e **config_jornal**

Cria versão em PDF (RGB) do jornal baseado em arquivos PDF (CMYK) individuais e publica arquivo processado no perfil do [Issuu](http://issuu.com) correspondente aos *tokens* (API token e API secret) fornecidos no arquivo de configuração.

> A publicação não será publicada com uma *descrição*. Se desejar inserí-la, entre em sua conta no Issuu e edite a publicação manualmente.

[jornal.sh](https://raw2.github.com/GrupoMauaRegiao/shell/master/jornal.sh)

```

./jornal.sh numero_edicao [numero_da_pagina_fora_do_padrao]

```


[config_jornal](https://raw2.github.com/GrupoMauaRegiao/shell/master/config_jornal)

```

api_token, api_secret

```
---

* **converter-videos.sh**

Converte vídeos de formatos `.wmv`, `.mp4` ou `.avi` para `.flv` com qualidade de imagem e áudio adequadas para publicação.

```

./converter_videos.sh

```
---