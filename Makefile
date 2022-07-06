REPO_ORG := LyraPhase
REPO_NAME := homebrew-pcloud
REPO := $(REPO_ORG)/$(REPO_NAME)
CASK_NAME := pcloud-drive
HOMEBREW_LIBRARY_TAPS := $(shell brew --repo)/Library/Taps
TAP_DIR := $(HOMEBREW_LIBRARY_TAPS)/$(REPO_ORG)

DEFAULT_GOAL: help ## no-help

.PHONY: help install test

help: ## Shows this generated help info for Makefile targets
	@grep -E '^[a-zA-Z_-]+:' $(MAKEFILE_LIST) | awk '{ c=split($$0,resultArr,/:+/) ; if ( !(resultArr[c-1] in targets) ) { if ( /:.*##/ ) { if ( ! /no-help/ ) { sub(/^.*## ?/," ",resultArr[c]); targets[resultArr[c-1]] = resultArr[c]; } } else { targets[resultArr[c-1]] = "" } } } END { for (target in targets) { printf "\033[36m%-30s\033[0m %s\n", target, targets[target] } }' | sort

$(TAP_DIR): ## no-help
	mkdir -p $(TAP_DIR)

$(TAP_DIR)/$(REPO_NAME):
	ln -s $(PWD) $(TAP_DIR)/$(REPO_NAME)

install: $(TAP_DIR) $(TAP_DIR)/$(REPO_NAME) ## Install Tap via git checkout symlink (development mode)
	brew tap --repair
	brew tap

test: install ## Run tests
	brew audit --cask $(CASK_NAME)
	brew install --cask --verbose $(CASK_NAME)
	pkgutil --pkgs=com.mobileinno.pkg.pCloudDrive

.github/clear_github_actions_cache:
	date  +%s > .github/clear_github_actions_cache

.PHONY: clean-github-cache-file clear-github-cache
clear-github-cache: clean-github-cache-file .github/clear_github_actions_cache ## Force GitHub Actions Cache key to change for fresh CI run
	git add .github/clear_github_actions_cache
	git commit -m "Clear GitHub Actions Cache @ $$(cat .github/clear_github_actions_cache)"

clean-github-cache-file: ## Remove GitHub Actions Cache timestamp invalidator file.
	[ -f '.github/clear_github_actions_cache' ] && rm -f '.github/clear_github_actions_cache' || true

clean:: ## Remove temporary/build files.
	rm -rf $(TAP_DIR)/$(REPO_NAME)
