FROM golang:1.20-alpine AS builder

WORKDIR /app
COPY . .

RUN go mod download
RUN go mod tidy
RUN go build -o mailhog-server

FROM alpine:3.14

WORKDIR /app
COPY --from=builder /app/mailhog-server .

EXPOSE 1025 8025

ENTRYPOINT ["/app/mailhog-server"]
