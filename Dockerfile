FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o tracker .
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/tracker ./
RUN touch tracker.db
ENTRYPOINT ["./tracker"]