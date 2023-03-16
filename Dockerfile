FROM harbor.adamkoro.com/bci/golang:1.19
WORKDIR /build
RUN git clone https://github.com/hikhvar/ts3exporter.git && cd ts3exporter && GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build

FROM harbor.adamkoro.com/bci/bci-micro:15.4
WORKDIR /home/user
COPY --from=0 /build/ts3exporter/ts3exporter .
COPY entrypoint.sh .
ENV REMOTE="localhost" \
PORT="10011" \
TS_USER="serveradmin" \
TS_PASS="password" \
TS_PASS_FILE="pass"
RUN echo "user:x:10000:10000:user:/home/user:/bin/bash" >> /etc/passwd && chown -R user /home/user/ && chmod +x ts3exporter
USER user
EXPOSE 9189
ENTRYPOINT ["./entrypoint.sh"]
