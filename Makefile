$stdout.sync = true

.DEFAULT_GOAL := help

# cribbed from https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html and https://news.ycombinator.com/item?id=11195539
help:  ## print documentation for available commands
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)

.PHONY: install
install: brew bundle asdf git vscode zsh #wm ## install & configure everything

.PHONY: brew
brew: ## install homebrew
	sh -c $$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)

.PHONY: bundle
bundle: brew ## install apps from Brewfile
	brew bundle

.PHONY: asdf
asdf: ## configure asdf, install plugins
	ln -Ffs $(PWD)/.asdfrc ~/.asdfrc

.PHONY: git
git: ## configure git
	ln -Ffs $(PWD)/.gitconfig ~/.gitconfig

.PHONY: vscode
vscode: ## configure vscode, install extensions
	code --install-extension bierner.markdown-emoji
	code --install-extension bierner.markdown-preview-github-styles
	code --install-extension dracula-theme.theme-dracula
	code --install-extension eamodio.gitlens
	code --install-extension EditorConfig.EditorConfig
	code --install-extension esbenp.prettier-vscode
	code --install-extension jeff-hykin.code-eol
	code --install-extension streetsidesoftware.code-spell-checker
	code --install-extension TabNine.tabnine-vscode
	code --install-extension vscode-icons-team.vscode-icons
#	ln -Ffs $(PWD)/Code/keybindings.json ~/Library/Application\ Support/Code/User/
#	ln -Ffs $(PWD)/Code/settings.json ~/Library/Application\ Support/Code/User/

.PHONY: zsh
zsh: # configure zsh, install plugins
	ln -Ffs $(PWD)/.zshrc ~/.zshrc
#	ln -Ffs $(PWD)/zsh-notify-alerter ~/.zsh-notify-alerter
#	git clone git@github.com:marzocchi/zsh-notify.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/notify
