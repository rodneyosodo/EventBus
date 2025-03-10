.PHONY: lint
lint:
	golangci-lint cache clean && golangci-lint run

.PHONY: examples
examples:
	go run examples/main.go

.PHONY: test
test:
	go test -v --race -covermode=atomic -coverprofile cover.out $(go list ./... | grep -v /examples)

.PHONY: bench
bench:
	go test -v -bench='.' -cpuprofile='cpu.prof' -memprofile='mem.prof'

.PHONY: cover-html
cover-html: test
	go tool cover -html cover.out -o cover.html

.PHONY: help
help:
	@echo "Please use \`make <target>\` where <target> is one of"
	@echo "  lint        to run golangci-lint"
	@echo "  examples    to run examples"
	@echo "  test        to run tests"
	@echo "  bench       to run benchmarks"
	@echo "  cover-html  to generate cover.html"
	@echo "  help        to display this help message"
