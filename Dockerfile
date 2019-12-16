FROM golang:1-alpine as builder
ENV HUGOVERSION 0.57.2
RUN \
	apk add build-base git && \
	git clone -b v${HUGOVERSION} https://github.com/gohugoio/hugo.git && \
	cd hugo && \
	go build --tags extended && \
	strip hugo

FROM alpine
COPY --from=builder /go/hugo/hugo /bin/hugo
RUN \
	apk add --no-cache libstdc++ && \
	rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/hugo"]
