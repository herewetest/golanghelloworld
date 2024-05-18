FROM golang:1.22 as builder

COPY . .
RUN go build -ldflags "-linkmode external -extldflags -static" -o helloworld

# ----------------------------------

FROM scratch

COPY --from=builder /go/helloworld .

CMD ["./helloworld"]
