FROM ubuntu:latest
RUN  yes | apt update 
RUN  yes | apt install m4 git make wget unzip build-essential fswatch python
RUN  wget https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh
RUN  echo "\n" | sh ./install.sh
RUN  yes | opam init --disable-sandboxing

ENV OPAM_SWITCH_PREFIX='/root/.opam/default'
ENV CAML_LD_LIBRARY_PATH='/root/.opam/default/lib/stublibs:/root/.opam/default/lib/ocaml/stublibs:/root/.opam/default/lib/ocaml'
ENV OCAML_TOPLEVEL_PATH='/root/.opam/default/lib/toplevel'
ENV MANPATH=':/root/.opam/system/man:/root/.opam/default/man'
ENV PATH='/root/.opam/default/bin:/root/.opam/system/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH}'

WORKDIR /root/src

RUN  yes | opam repo add janestreet-bleeding https://ocaml.janestreet.com/opam-repository
RUN  opam update
RUN  opam install -y dune core_kernel incr_dom  js_of_ocaml

COPY src  ./
RUN  touch main.ml
RUN  dune build ./main.bc.js
RUN  ls _build/default/
EXPOSE 9000
ENTRYPOINT bash ./dev.sh
