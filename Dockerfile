
FROM alpine:3.10

RUN apk update && apk upgrade && \
    apk add --no-cache git openssh rsync

COPY sync.sh /sync.sh

RUN chmod +x sync.sh

ENTRYPOINT ["/sync.sh"]
