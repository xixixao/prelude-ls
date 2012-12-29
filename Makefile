CoffeeScript = coffee
Uglify = uglifyjs

all: build

build: prelude.js prelude-min.js prelude-browser.js prelude-browser-min.js

test: test.js prelude.js
	jasmine-node --matchall test.js | egrep -v '^    at'

prelude.js: prelude.coffee
	$(CoffeeScript) -c prelude.coffee

prelude-min.js: prelude.js
	$(Uglify) prelude.js -o prelude-min.js

prelude-browser.js: prelude.js
	$(CoffeeScript) ./browsify.coffee

prelude-browser-min.js: prelude-browser.js
	$(Uglify) prelude-browser.js -o prelude-browser-min.js -m -r 'define'

test.js: test.coffee
	$(CoffeeScript) -c test.coffee

clean:
	rm ./*.js

.PHONY: all clean build test