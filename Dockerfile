FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.22 as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

COPY . .
RUN case "$(uname -m)" in \
    armv6l|armv6) export GOARM=6 ;; \
    armv7l|armv7) export GOARM=7 ;; \
    *) true ;; \
    esac

RUN GOOS=${TARGETOS} GOARCH=${TARGETARCH} CGO_ENABLED=1 go build -ldflags "-s -w -linkmode external -extldflags -static" -o helloworld .

# ----------------------------------

FROM --platform=${BUILDPLATFORM:-linux/amd64} gcr.io/distroless/static:nonroot

LABEL org.opencontainers.image.source=https://github.com/herewetest/golanghelloworld

COPY --from=builder /go/helloworld .

USER nonroot:nonroot

CMD ["./helloworld"]
