# Variables
DIRS = $(notdir $(wildcard config/*))
FILES = .Xresources .stalonetrayrc

update:
	@rm -rf config/zsh/plugins

	@for i in $(DIRS); do \
		cp -r ~/.config/$$i config; \
	done

	@for i in $(FILES); do \
		cp ~/$$i .; \
	done

	@echo "Dotfiles updated successfully."

install:
	@for i in $(DIRS) ; do \
		cp -rv $$i ~/.config/; \
	done

	@for i in $(FILES); do \
		cp $$i ~; \
	done

	@# nvim plugin manager
	git clone --depth 1 https://github.com/wbthomason/packer.nvim \
		~/.local/share/nvim/site/pack/packer/start/packer.nvim

	@# zsh plugins
	@mkdir -p ~/.config/zsh/plugins/
	git clone https://github.com/hlissner/zsh-autopair.git ~/.config/zsh/plugins/zsh-autopair
	git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.config/zsh/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting

	@echo "Dotfiles installed successfully."
