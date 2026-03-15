PACKAGES := $(shell find . -maxdepth 1 -mindepth 1 -type d -not -name '_*' -not -name '.*' -printf '%f\n')

all:
	stow --verbose --target=$$HOME --restow $(PACKAGES)
delete:
	stow --verbose --target=$$HOME --delete $(PACKAGES)
