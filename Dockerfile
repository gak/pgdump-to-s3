FROM alpine  

ENV GOPATH /root  

# Based off https://github.com/yep/s3/blob/master/Dockerfile
RUN \
   apk update && \
   apk add go git binutils postgresql musl-dev ca-certificates && \
   go get github.com/barnybug/s3/cmd/s3 && \
   strip /root/bin/s3 && \
   apk del go git binutils && \
   rm /var/cache/apk/* && \
   mv /root/bin/s3 /usr/local/bin && \
   rm -rf /root/*

ADD backup.sh /

CMD /backup.sh
