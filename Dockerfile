FROM golang:1.16 AS builder

RUN apt-get update
RUN apt-get install -y pkg-config libaio1

WORKDIR /app
COPY ./instantclient_21_1 ./instantclient
COPY docker/oci8.pc ./
ENV PKG_CONFIG_PATH=/app
ENV LD_LIBRARY_PATH=/app/instantclient:$LD_LIBRARY_PATH

COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o main

CMD ["./main"]

# glibc is needed by instantclient, but alpine does not provide it
# https://stackoverflow.com/questions/66963068/docker-alpine-executable-binary-not-found-even-if-in-path

# FROM golang:1.16-alpine

# RUN apk update
# RUN apk add libaio
# RUN apk add glibc

# WORKDIR /app
# ENV LD_LIBRARY_PATH=/app/instantclient:$LD_LIBRARY_PATH

# COPY --from=builder /app/instantclient ./instantclient
# COPY --from=builder /app/main ./main

# CMD ["./main"]