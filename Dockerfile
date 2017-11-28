# Inspired by: https://hub.docker.com/r/znly/upx/~/dockerfile/
FROM alpine:edge AS build-env
RUN apk add --no-cache build-base ucl-dev zlib-dev git
# ENV UPX_VERSION=96433b4e39f230c935cb35e6e9125c1aec3ae29f \
#     LDFLAGS=-static
RUN git clone --depth 1 --recursive -b devel https://github.com/upx/upx.git /upx
RUN cd /upx/src && \
    make -j2 upx.out CHECK_WHITESPACE=
RUN /upx/src/upx.out --brute -o /usr/bin/upx /upx/src/upx.out

FROM scratch
COPY --from=build-env /usr/bin/upx /usr/bin/upx
