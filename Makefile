$stdout.sync = true

.DEFAULT_GOAL := help

# cribbed from https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html and https://news.ycombinator.com/item?id=11195539
help:  ## print documentation for available commands
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)

.PHONY: install
install: brew bundle asdf cows git pock sounds vscode zsh #wm ## install & configure everything

.PHONY: brew
brew: ## install homebrew
	sh -c $$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)

.PHONY: bundle
bundle: brew ## install apps from Brewfile
	brew bundle

.PHONY: asdf
asdf: ## configure asdf, install plugins
	ln -Ffs $(PWD)/.asdfrc ~/.asdfrc
	ln -Ffs $(PWD)/.tool-versions ~/.tool-versions
	ln -Ffs $(PWD)/gemrc ~/.gemrc
	asdf plugin-add ruby | sed '/already/d'
	asdf install ruby latest
	asdf plugin-add nodejs | sed '/already/d'
	asdf install nodejs lts
	asdf plugin-add yarn | sed '/already/d'
	asdf install yarn latest

.PHONY: cows
cows: ## install lolcat, custom cows
	sudo gem install lolcat
	install -m 644 cows/*.cow $(HOMEBREW_PREFIX)/opt/cowsay/share/cows/
	ln -Ffs $(PWD)/lolcowsay /usr/local/bin/lolcowsay

.PHONY: entertainment
entertainment: ## install entertainment apps
	brew bundle --file=Entertainment.brewfile

.PHONY: git
git: ## configure git
	ln -Ffs $(PWD)/.gitconfig ~/.gitconfig
	ln -Ffs $(PWD)/.gitignore ~/.gitignore

.PHONY: pock
pock: ## configure pock
	ln -Ffs $(PWD)/Library/Preferences/com.pigigaldi.pock.plist ~/Library/Preferences/com.pigigaldi.pock.plist

.PHONY: sounds
sounds: ## install custom notification sounds
	install -m 644 sounds/*.aif ~/Library/Sounds/

.PHONY: ubersicht
ubersicht: ## configure ubersicht
	rm -rf ~/Library/Application\ Support/Übersicht/widgets
	ln -Ffs $(PWD)/ubersicht/widgets ~/Library/Application\ Support/Übersicht/

.PHONY: vscode
vscode: ## configure vscode, install extensions
	code --install-extension bierner.markdown-emoji
	code --install-extension bierner.markdown-preview-github-styles
	code --install-extension deerawan.vscode-dash
	code --install-extension dracula-theme.theme-dracula
	code --install-extension eamodio.gitlens
	code --install-extension esbenp.prettier-vscode
	code --install-extension fabiospampinato.vscode-todo-plus
	code --install-extension jeff-hykin.code-eol
	code --install-extension lourenci.go-to-spec
	code --install-extension mikestead.dotenv
	code --install-extension ms-azuretools.vscode-docker
	code --install-extension rebornix.ruby
	code --install-extension streetsidesoftware.code-spell-checker
	code --install-extension TabNine.tabnine-vscode
	code --install-extension wingrunr21.vscode-ruby
	code --install-extension ziyasal.vscode-open-in-github
	ln -Ffs $(PWD)/Code/keybindings.json ~/Library/Application\ Support/Code/User/
	ln -Ffs $(PWD)/Code/settings.json ~/Library/Application\ Support/Code/User/

.PHONY: wm
wm: $(HOME)/.skhdrc $(HOME)/.yabairc ## configure yabai wm
	install -m 755 bin/yabai-columns-3 /usr/local/bin/
	# install -m 755 bin/yabai-fullscreen /usr/local/bin/
	brew services restart yabai
	brew services restart skhd

$(HOME)/.skhdrc:
	ln -Ffs $(PWD)/skhdrc $(HOME)/.skhdrc

$(HOME)/.yabairc:
	ln -Ffs $(PWD)/yabairc $(HOME)/.yabairc

.PHONY: zsh
zsh: # configure zsh, install plugins
	sh -c $$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)
	ln -Ffs $(PWD)/.zshrc ~/.zshrc
	git clone https://github.com/bhilburn/powerlevel9k.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
	git clone git@github.com:marzocchi/zsh-notify.git $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/notify
