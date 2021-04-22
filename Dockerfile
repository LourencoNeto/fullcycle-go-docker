# Stage 1 #

FROM golang:1.16.3-alpine3.13 as builder

RUN mkdir -p /app
WORKDIR /app

RUN go mod init example.com/fullcycle-go

COPY app.go .

RUN CGO_ENABLED=0 GOOS=linux go build ./app.go

# Stage 2 #

FROM scratch

WORKDIR /app

COPY --from=builder /app/app .

CMD ["/app/app"]