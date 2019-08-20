default: install-tools clean install build-prod

install-tools:
	command -v concurrently >/dev/null 2>&1 || { npm install -g concurrently >&2; }
	command -v http-server >/dev/null 2>&1 || { npm install -g http-server >&2; }

clean:
	concurrently \
		"cd src/animate && yarn clean" \
		"cd src/preact && yarn clean" \
		"cd src/react && yarn clean" \
		"cd src/router && yarn clean" \
		"cd src/svelte && yarn clean" \
		"cd src/transition && yarn clean" \
		"cd src/vue && yarn clean"
	concurrently \
		"find . -name node_modules -exec rm -r -f '{}' +" \
		"find . -name dist -exec rm -r -f '{}' +" \
		"find . -name build -exec rm -r -f '{}' +" 

install:
	yarn install

build:
	cd src/router && yarn build
	concurrently \
		"cd src/animate && yarn build" \
		"cd src/preact && yarn build" \
		"cd src/react && yarn build" \
		"cd src/svelte && yarn build" \
		"cd src/transition && yarn build" \
		"cd src/vue && yarn build"

build-prod:
	cd src/router && yarn build:prod
	concurrently \
		"cd src/animate && yarn build:prod" \
		"cd src/preact && yarn build:prod" \
		"cd src/react && yarn build:prod" \
		"cd src/svelte && yarn build:prod" \
		"cd src/transition && yarn build:prod" \
		"cd src/vue && yarn build:prod"

dev:
	cd src/router && yarn build
	concurrently \
		"cd src/router && yarn build:watch" \
		"cd src/animate && yarn build:watch" \
		"cd src/preact && yarn build:watch" \
		"cd src/react && yarn build:watch" \
		"cd src/svelte && yarn build:watch" \
		"cd src/transition && yarn build:watch" \
		"cd src/vue && yarn build:watch"

test:
	cd src/router && yarn test
	cd src/animate && yarn test
	cd src/preact && yarn test
	cd src/react && yarn test
	cd src/svelte && yarn test
	cd src/transition && yarn test
	cd src/vue && yarn test