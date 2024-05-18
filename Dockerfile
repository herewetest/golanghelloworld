FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.22 as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY . .
RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} CGO_ENABLED=1 go build -ldflags "-s -w -linkmode external -extldflags -static" -o helloworld .

# ----------------------------------

FROM --platform=${BUILDPLATFORM:-linux/amd64} gcr.io/distroless/static:nonroot

LABEL org.opencontainers.image.source=https://github.com/herewetest/golanghelloworld

COPY --from=builder /go/helloworld .

USER nonroot:nonroot

CMD ["./helloworld"]
