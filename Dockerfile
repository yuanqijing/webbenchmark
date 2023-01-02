ARG GOLANG_VERSION="1.18"
FROM golang:$GOLANG_VERSION-alpine as builder

WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -mod vendor -o /src/main ./cmd/main.go

FROM alpine:3.14

COPY --from=builder /src/main /src/main
WORKDIR /src

CMD chmod +x main && ./main