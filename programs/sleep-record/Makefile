.PHONY: dev
dev: src/index.ts
	npx tsx $<

.PHONY: build
build: dist/index.mjs

dist/index.mjs: src/index.ts
	npx pkgroll
