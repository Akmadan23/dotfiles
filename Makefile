# Variables
DIRS = $(notdir $(wildcard config/*))

update:
	@rm -rf config/zsh/plugins

	@for d in $(DIRS); do \
		cp -r ~/.config/$$d config; \
	done

	@echo "Dotfiles updated successfully."

install:
	@for d in $(DIRS); do \
		cp -rv config/$$d ~/.config/; \
	done

	@for f in $(FILES); do \
		cp $$f ~; \
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
