all: my-snippet.css hotkeys.json

my-snippet.css: appearance.scss assets.scss
	sass --no-source-map $< $@

hotkeys.json: gen-hotkeys.sh hotkeys.template.json
	. ./$<

clean:
	rm my-snippet.css hotkeys.json

.PHONY: all clean
