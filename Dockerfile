FROM golang:1.21 as build
WORKDIR /src
ADD / /src
RUN go mod download
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
RUN cd ./examples/helloworld/greeter_client && go build -o /bin/client main.go
RUN cd ./examples/helloworld/greeter_server && go build -o /bin/server main.go

FROM scratch
COPY --from=build /bin/client /bin/
COPY --from=build /bin/server /bin/
ENTRYPOINT []

