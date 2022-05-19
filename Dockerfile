FROM golang:1.18.0-bullseye as builder
RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -mod=vendor -a -o service .

FROM alpine:3.11.3
RUN apk --no-cache add ca-certificates
COPY --from=builder /build/service .
EXPOSE 9090
ENTRYPOINT [ "./service" ]