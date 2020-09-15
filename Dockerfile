FROM golang:1.12-alpine as builder

ENV GO111MODULE=on
WORKDIR /go/src/slo-app
RUN apk add --no-cache git

COPY . .
RUN go get ./...
RUN CGO_ENABLED=0 GOOS=linux go build -v -o /go/bin/slo-app


FROM scratch
COPY --from=builder /go/bin/slo-app /tmp/
ENTRYPOINT ["/tmp/slo-app"]
