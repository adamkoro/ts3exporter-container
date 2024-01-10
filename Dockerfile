FROM registry.suse.com/bci/bci-base:15.5 as build
WORKDIR /build
ARG TS3EXPORTER_VERSION
RUN zypper ref && zypper -n in wget
RUN curl -L https://github.com/hikhvar/ts3exporter/releases/download/v${TS3EXPORTER_VERSION}/ts3exporter_${TS3EXPORTER_VERSION}_linux_amd64.tar.gz -o ts3exporter.tar.gz && ls -la && tar -xzf ts3exporter.tar.gz


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
HEALTHCHECK --interval=5s --timeout=2s --start-period=10s --retries=3 CMD wget --no-verbose --tries=1 --spider http://localhost:9189/metrics || exit 1
COPY --chmod=0550 --from=build --chown=10000:10000 /build/ts3exporter .
COPY --chmod=0550 --chown=10000:10000 entrypoint.sh .
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