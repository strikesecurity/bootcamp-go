BINARY=service
SERVICE_NAME=`pwd | rev | cut -d '/' -f 1 | rev`

build:
	go build -ldflags "-s -w -X github.com/strikesecurity/${SERVICE_NAME}/app.version=`date -u +%Y%m%d.%H%M%S` -X github.com/strikesecurity/${SERVICE_NAME}/app.commitHash=`git log --pretty=format:'%h' -n 1`" -o ${BINARY} *.go
test_local:
	go test -cover ./...

test:
	go test -json > report.json -cover -coverprofile=coverage.out -race ./...

web:
	@clear
	go build -o ${BINARY} *.go
	./${BINARY}