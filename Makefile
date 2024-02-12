PHP_BIN             := php
COMPOSER_BIN        := composer
NPM_BIN				:= npm

C_RED		= \033[0;31m
C_GREEN		= \033[0;32m
C_YELLOW	= \033[0;33m
C_CYAN		= \033[0;36m
C_NC		= \033[0m # No Color

THEME_PATH  = "user/themes/chassis/"

.PHONY: list
list:
	@echo ""
	@echo "Useful targets:"
	@echo ""
	@echo "  install    > install everything to run the project"
	@echo "  update     > update grav and plugins to latest stable version"
	@echo "  clear      > clear cache"
	@echo ""
	@echo "  themeinit  > install dependencies for theme building"
	@echo "  watch      > development mode"
	@echo "  lint       > lint code"
	@echo "  build      > build code for release"
	@echo "  jsmin      > quick build of js for release"
	@echo "  cssmin     > quick build of css for release"
	@echo ""


.PHONY: install
# install: is_installed grav_prepare grav_theme update
install: is_installed grav_prepare
	@echo "$(C_GREEN)Installation complete.$(C_NC)"

is_installed:
ifneq (,$(wildcard ./index.php))
	@echo "$(C_RED)Already installed.$(C_NC)"
	@exit 1
endif
	@echo "$(C_GREEN)Here we go.$(C_NC)"

grav_prepare:
	@echo ""
	@echo "$(C_CYAN)Downloading and preparing grav CMS$(C_NC)"
	@curl -o grav.zip -SL https://getgrav.org/download/core/grav/latest
	@unzip grav.zip -d ./ > /dev/null
	@rm grav.zip
	@rm -rf grav/user/
	@rm -rf grav/.github/
	@rm grav/README.md grav/LICENSE.txt grav/CONTRIBUTING.md grav/CODE_OF_CONDUCT.md grav/CHANGELOG.md
	@mv -n grav/* ./
	@mv -n grav/.[!.]* ./
	@rm -rf grav/
	@mkdir -p user/data/flex-objects
	@echo "$(C_CYAN)Installing dependencies$(C_NC)"
	@./bin/grav install

.PHONY: update
update:
	@echo ""
	@echo "$(C_CYAN)Installing and updating dependencies$(C_NC)"
	@mv readme.md readme.dist.md
	@./bin/grav install
	@./bin/gpm selfupgrade
	@./bin/gpm update
	@mv readme.dist.md readme.md

.PHONY: clear
clear:
	@./bin/grav cache


.PHONY: themeinit
themeinit:
	@npm install --prefix $(THEME_PATH)

.PHONY: lint
lint:
	@npm run lint --prefix $(THEME_PATH)

.PHONY: watch
watch:
	@npm run watch --prefix $(THEME_PATH)

.PHONY: build
build:
	@npm run build --prefix $(THEME_PATH)

.PHONY: jsmin
jsmin:
	@npm run jsmin --prefix $(THEME_PATH)

.PHONY: cssmin
cssmin:
	@npm run cssmin --prefix $(THEME_PATH)
