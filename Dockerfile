ARG TS3EXPORTER_VERSION

FROM registry.suse.com/bci/golang:1.21 as build
WORKDIR /build
ARG TS3EXPORTER_VERSION
RUN curl -L https://github.com/hikhvar/ts3exporter/archive/refs/tags/v${TS3EXPORTER_VERSION}.tar.gz -o ts3exporter-${TS3EXPORTER_VERSION}.tar.gz && ls -la && tar -xzf ts3exporter-${TS3EXPORTER_VERSION}.tar.gz
ARG TS3EXPORTER_VERSION
RUN cd ts3exporter-${TS3EXPORTER_VERSION} && GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build


FROM registry.suse.com/bci/bci-micro:15.5
WORKDIR /home/user
ARG TS3EXPORTER_VERSION
COPY --chmod=0550 --from=build /build/ts3exporter-${TS3EXPORTER_VERSION}/ts3exporter .
COPY --chmod=0550 entrypoint.sh .
ENV REMOTE="localhost" \
PORT="10011" \
TS_USER="serveradmin" \
TS_PASS="password" \
TS_PASS_FILE="pass"
RUN echo "user:x:10000:10000:user:/home/user:/bin/bash" >> /etc/passwd && chown -R user /home/user/
USER user
EXPOSE 9189
ENTRYPOINT ["./entrypoint.sh"]
