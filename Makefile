GITHUB_USER := trinitronx
REPO_NAME := homebrew-pcloud
REPO := $(GITHUB_USER)/$(REPO_NAME)
CASK_NAME := pcloud-drive
HOMEBREW_LIBRARY_TAPS := $(shell brew --repo)/Library/Taps
TAP_DIR := $(HOMEBREW_LIBRARY_TAPS)/$(GITHUB_USER)
HOMEBREW_PREFIX := $(shell brew --prefix)
CASKROOM := $(HOMEBREW_PREFIX)/Caskroom
LIBRARY_CASK_CACHE := $(HOME)/Library/Caches/Homebrew/Cask

DEFAULT_GOAL: help ## no-help

.PHONY: help download install test

help: ## Shows this generated help info for Makefile targets
	@grep -E '^[a-zA-Z_-]+:' $(MAKEFILE_LIST) | awk '{ c=split($$0,resultArr,/:+/) ; if ( !(resultArr[c-1] in targets) ) { if ( /:.*##/ ) { if ( ! /no-help/ ) { sub(/^.*## ?/," ",resultArr[c]); targets[resultArr[c-1]] = resultArr[c]; } } else { targets[resultArr[c-1]] = "" } } } END { for (target in targets) { printf "\033[36m%-30s\033[0m %s\n", target, targets[target] } }' | sort

$(TAP_DIR): ## no-help
	mkdir -p $(TAP_DIR)

$(TAP_DIR)/$(REPO_NAME):
	ln -s $(PWD) $(TAP_DIR)/$(REPO_NAME)

install: $(TAP_DIR) $(TAP_DIR)/$(REPO_NAME) ## Install Tap via git checkout symlink (development mode)
	brew tap --repair
	brew tap

$(LIBRARY_CASK_CACHE)/$(CASK_NAME)-*.pkg:
	brew cask audit --download $(CASK_NAME)
	xattr -rd com.apple.quarantine $(LIBRARY_CASK_CACHE)/$(CASK_NAME)-*.pkg
download: $(LIBRARY_CASK_CACHE)/$(CASK_NAME)-*.pkg ## Download Cask

test: install ## Run tests
	brew cask audit $(CASK_NAME)
	brew cask install --verbose $(CASK_NAME)
	pkgutil --pkgs=com.mobileinno.pkg.pCloudDrive

clean:: ## Remove temporary/build files.
	rm -rf $(TAP_DIR)/$(REPO_NAME)
