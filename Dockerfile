# Build stage
FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -o foobar-api

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/foobar-api .

EXPOSE 443

CMD ["./foobar-api", "-port=443"]

