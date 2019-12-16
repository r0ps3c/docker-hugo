FROM golang:1-alpine as builder
ENV HUGOVERSION 0.57.2
RUN \
	apk add git binutils && \
	git clone -b v${HUGOVERSION} https://github.com/gohugoio/hugo.git && \
	cd hugo && \
	go build && \
	strip hugo

FROM alpine
COPY --from=builder /go/hugo/hugo /bin/hugo
ENTRYPOINT ["/bin/hugo"]
