
build: components
	@coffee -b -o . -j \
		index.coffee \
		src/index.coffee \
		src/director.coffee \
		src/directive.coffee \
		src/directives/confirm.coffee \
		src/directives/alert.coffee \
		src/directives/trigger.coffee

	@component build --dev

components: component.json
	@component install --dev

clean:
	rm -fr build components template.js


.PHONY: clean test
