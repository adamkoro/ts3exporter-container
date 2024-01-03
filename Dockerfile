ARG TS3EXPORTER_VERSION

FROM registry.suse.com/bci/golang:1.21 as build
WORKDIR /build
ARG TS3EXPORTER_VERSION
RUN zypper ref && zypper -n in wget
RUN curl -L https://github.com/hikhvar/ts3exporter/archive/refs/tags/v${TS3EXPORTER_VERSION}.tar.gz -o ts3exporter-${TS3EXPORTER_VERSION}.tar.gz && ls -la && tar -xzf ts3exporter-${TS3EXPORTER_VERSION}.tar.gz
ARG TS3EXPORTER_VERSION
RUN cd ts3exporter-${TS3EXPORTER_VERSION} && GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build


FROM registry.suse.com/bci/bci-minimal:15.5
WORKDIR /home/user
ENV REMOTE="localhost" \
PORT="10011" \
TS_USER="serveradmin" \
TS_PASS="password" \
TS_PASS_FILE="pass"
RUN echo "user:x:10000:10000:user:/home/user:/bin/bash" >> /etc/passwd && chown -R user /home/user/
USER user
EXPOSE 9189
ENTRYPOINT ["./entrypoint.sh"]
ARG TS3EXPORTER_VERSION
COPY --chmod=0550 --from=build /build/ts3exporter-${TS3EXPORTER_VERSION}/ts3exporter .
COPY --chmod=0550 entrypoint.sh .
COPY --chmod=0555 --from=build /usr/bin/wget /usr/bin/wget
COPY --chmod=0555 --from=build  /usr/lib/libproxy* /usr/lib/
COPY --chmod=0555 --from=build  /usr/lib64/libproxy* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libmetalink* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libcares* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libpcre2* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libuuid* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libidn2* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libssl* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libcrypto* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libz* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libpsl* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libgpgme* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libexpat* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libunistring* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libjitterentropy* /usr/lib64/
COPY --chmod=0555 --from=build  /usr/lib64/libassuan* /usr/lib64/