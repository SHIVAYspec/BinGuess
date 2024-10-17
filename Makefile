.PHONY : build clean

build:
	elm make --output=dist/index.html src/Main.elm

clean:
	rm -rf dist