$stdout.sync = true

.DEFAULT_GOAL := help

# cribbed from https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html and https://news.ycombinator.com/item?id=11195539
help:  ## print documentation for available commands
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)

.PHONY: install
install: brew bundle asdf cows git pock sounds vscode wm zsh ## install & configure everything

.PHONY: brew
brew: ## install homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

.PHONY: bundle
bundle: brew ## install apps from Brewfile
	brew bundle

.PHONY: asdf
asdf: ## configure asdf, install plugins
	ln -s $(pwd)/.asdfrc ~/.asdfrc
	asdf plugin-add ruby
	asdf install ruby latest
	asdf plugin-add nodejs
	asdf install nodejs latest
	asdf plugin-add yarn
	asdf install yarn latest

.PHONY: cows
cows: ## install lolcat, custom cows
	sudo gem install lolcat
	install -m 644 cows/*.cow /usr/local/opt/cowsay/share/cows/
	cp lolcowsay /usr/local/bin/
	ln -s $(pwd)/lolcowsay /usr/local/bin/lolcowsay

.PHONY: git
git: ## configure git
	ln -s $(pwd)/.gitconfig ~/.gitconfig
	ln -s $(pwd)/.gitignore ~/.gitignore

.PHONY: pock
pock:
	ln -s $(pwd)/Library/Preferences/com.pigigaldi.pock.plist ~/Library/Preferences/com.pigigaldi.pock.plist

.PHONY: sounds
sounds: ## install custom notification sounds
	install -m 644 sounds/*.aif ~/Library/Sounds/

.PHONY: ubersicht
ubersicht: ## configure ubersicht
	rm -rf ~/Library/Application\ Support/Übersicht/widgets
	ln -s $(pwd)/ubersicht/widgets ~/Library/Application\ Support/Übersicht/

.PHONY: vscode
vscode: ## configure vscode, install extensions
	code --install-extension bierner.markdown-emoji
	code --install-extension bierner.markdown-preview-github-styles
	code --install-extension CoenraadS.bracket-pair-colorizer-2
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
	code --install-extension robertohuertasm.vscode-icons
	code --install-extension streetsidesoftware.code-spell-checker
	code --install-extension TabNine.tabnine-vscode
	code --install-extension wingrunr21.vscode-ruby
	code --install-extension ziyasal.vscode-open-in-github
	ln -s $(pwd)/Code/keybindings.json ~/Library/Application\ Support/Code/User/
	ln -s $(pwd)/Code/settings.json ~/Library/Application\ Support/Code/User/

.PHONY: wm
wm: ## configure yabai wm
	ln -s $(pwd)/yabairc ~/.yabairc
	ln -s $(pwd)/skhdrc ~/.skhdrc
	brew services start yabai
	brew services start skhd

.PHONY: zsh
zsh: # configure zsh, install plugins
	echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
	chsh -s /usr/local/bin/zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel9k
	git clone git@github.com:marzocchi/zsh-notify.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/notify
	ln -s $(pwd)/.zshrc ~/.zshrc
