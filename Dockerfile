FROM harbor.adamkoro.com/bci/bci-micro:15.4
WORKDIR /home/user
COPY /tmp/ts3exporter .
ENV REMOTE="localhost" \
LISTEN="10011" \
TS_USER="serveradmin" \
TS_PASS="password" \
TS_PASS_FILE="pass"
RUN echo "user:x:10000:10000:user:/home/user:/bin/bash" >> /etc/passwd && chown -R user /home/user/ && chmod +x ts3exporter
USER user
RUN echo "${TS_PASS}" > "${TS_PASS_FILE}" && chmod 600 "${TS_PASS_FILE}"
EXPOSE 9189
ENTRYPOINT ["sh","-c","./ts3exporter -remote ${REMOTE}:${LISTEN} -user ${TS_USER} -passwordfile ./${TS_PASS_FILE}"]
