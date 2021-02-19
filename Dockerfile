#
# Build stage
#

FROM golang:1.14-alpine as compiler

ARG github_user
ARG github_token
ENV GOPRIVATE "github.com/strikesecurity"
ENV GONOSUMDB=github.com/strikesecurity/*
WORKDIR /go/src/github.com/strikesecurity/bootcamp-go
COPY . .
RUN apk --no-cache add make \
 && apk --no-cache add git \
 && apk --no-cache add bash \
 && echo "machine github.com login ${github_user} password ${github_token}" > /root/.netrc \
 && make build

#
# Run stage
#

FROM alpine

COPY --from=compiler /go/src /go/src
RUN apk add --no-cache tzdata
WORKDIR /go/src/github.com/strikesecurity/bootcamp-go
CMD ./service
EXPOSE 8080
