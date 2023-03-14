
# syntax=docker/dockerfile:1

FROM golang:1.16-alpine

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY ./starter/ ./starter/
COPY ./worker/ ./worker/
COPY . .

RUN go build -o ./starter/ ./worker/

EXPOSE 8080 7233

CMD [ "./worker/main.go" "./starter/main.go" ]


