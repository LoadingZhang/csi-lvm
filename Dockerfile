FROM golang:1.13-alpine as builder
RUN apk add make binutils
COPY / /work
WORKDIR /work
RUN make all

FROM alpine:3.10
RUN apk add lvm2 e2fsprogs
COPY --from=builder /work/bin/csi-lvm-provisioner /csi-lvm-provisioner
USER nobody
ENTRYPOINT ["/csi-lvm-provisioner"]