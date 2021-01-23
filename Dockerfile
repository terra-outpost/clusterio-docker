FROM node:14-slim AS clusterio_builder

RUN apt-get update && apt-get install -y git
RUN git clone -b clusterio-2.0 https://github.com/clusterio/factorioClusterioMod.git /factorioClusterioMod
WORKDIR /factorioClusterioMod
RUN npm install
RUN node build

RUN git clone -b master https://github.com/clusterio/factorioClusterio /clusterio
WORKDIR /clusterio
RUN npm install
RUN npx lerna bootstrap --hoist
RUN mkdir sharedMods && cp /factorioClusterioMod/dist/* sharedMods

# Build submodules (web UI, libraries, plugins etc)
RUN npx lerna run build

# Build Lua library mod
RUN node packages/lib/build_mod --build --source-dir packages/slave/lua/clusterio_lib \
  && mv dist/* sharedMods/ \
  && mkdir temp \
  && mkdir temp/test \
  && cp sharedMods/ temp/test/ -r \
  && ls sharedMods

FROM liamcottam/factorio:experimental

WORKDIR /clusterio

RUN apk add --update nodejs npm
RUN ln -s /opt/factorio factorio
RUN npm init -y && npm install \
  @clusterio/master \
  @clusterio/slave \
  @clusterio/ctl \
  @clusterio/plugin-subspace_storage \
  @clusterio/plugin-global_chat

RUN npx clusteriomaster plugin add @clusterio/plugin-subspace_storage
RUN npx clusteriomaster plugin add @clusterio/plugin-global_chat
COPY --from=clusterio_builder /clusterio/sharedMods /clusterio/sharedMods

ENTRYPOINT [ "/init.sh" ]
COPY init.sh /init.sh
