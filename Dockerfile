
# syntax=docker/dockerfile:1

FROM golang:1.16-alpine

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o ./starter

EXPOSE 8080 7233

CMD [ "./worker/main.go" "./starter/main.go" ]


