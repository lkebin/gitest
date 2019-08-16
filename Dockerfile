FROM golang:1.12-alpine AS builder
COPY . /usr/local/src/gitest
WORKDIR /usr/local/src/gitest
ENV GOPROXY https://proxy.golang.org
RUN apk --no-cache add make git \
    && CGO_ENABLED=0 go build

FROM alpine:latest
COPY --from=builder /usr/local/src/gitest /gitest

ENTRYPOINT ["/gitest/gitest"]
