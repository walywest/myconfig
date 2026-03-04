.PHONY: build shell test clean

build:
	sudo docker build -t dns-debug .

shell: build
	sudo docker run -it --network host dns-debug

test: build
	@docker run --rm --network host dns-debug bash -c '\
		dig hyprland.cachix.org && \
		curl -I https://hyprland.cachix.org'

clean:
	docker rmi dns-debug
