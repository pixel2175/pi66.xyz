.PHONY: all build release dev install uninstall clean test

all: build

install:
	@printf "\033[1;34m==>\033[0m Installing...\n"
	@merodi build --release

build:
	@printf "\033[1;34m==>\033[0m Building...\n"
	@merodi build

dev:
	@printf "\033[1;34m==>\033[0m Starting development server...\n"
	@merodi watch & live-server draft --verbose

clean:
	@printf "\033[1;34m==>\033[0m Cleaning...\n"
	@merodi clean
