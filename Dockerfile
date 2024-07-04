FROM golang:1.22-alpine AS build
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY *.go ./
RUN go build -o /godocker

FROM scratch
WORKDIR /
COPY --from=build /godocker /godocker
EXPOSE 8080
ENV MONGODB_URI "mongodb://"
ENTRYPOINT ["/godocker"]
