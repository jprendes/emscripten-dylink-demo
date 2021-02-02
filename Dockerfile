FROM emscripten/emsdk:2.0.13

RUN \
  git clone --depth 1 --branch dylink-merged-fixes https://github.com/jprendes/emscripten.git /emscripten && \
  npm --prefix /emscripten install /emscripten && \
  mv /emsdk/upstream/emscripten /emsdk/upstream/emscripten_ && \
  ln -s /emscripten /emsdk/upstream/

WORKDIR /app/

ENTRYPOINT [ "./run.sh" ]