all: build

build:
	@docker build -t ${USER}/mongodb —-no-cache .
