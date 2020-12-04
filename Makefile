#!/usr/bin/make -f


# Install/Uninstall make script for paranoid-linux/generate-random-password
# Copyright (C) 2020 S0AndS0
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


#
#    Lambda-like functions
#
path_append = $(strip $(1))$(strip $(__PATH_SEPARATOR__))$(strip $(2))


#
#    Make variables to satisfy conventions
#
NAME = generate-random-password
VERSION = 0.0.1
PKG_NAME = $(NAME)-$(VERSION)


#
#    Make variables that readers &/or maintainers may wish to modify
#
INSTALL_DIRECTORY := $(HOME)/bin
SCRIPT_NAME := generate-random-password
MAN_PATH := $(firstword $(subst :, ,$(shell manpath)))
MAN_DIR_NAME := man1
GIT_BRANCH := main
GIT_REMOTE := origin


#
#    Make variables set upon run-time
#
##  Note ':=' is to avoid late binding that '=' entails
## Attempt to detect Operating System
ifeq '$(findstring :,$(PATH))' ';'
	__OS__ := Windows
else
	__OS__ := $(shell uname 2>/dev/null || echo 'Unknown')
	__OS__ := $(patsubst CYGWIN%,Cygwin,$(__OS__))
	__OS__ := $(patsubst MSYS%,MSYS,$(__OS__))
	__OS__ := $(patsubst MINGW%,MSYS,$(__OS__))
endif


ifeq '$(__OS__)' 'Windows'
	__PATH_SEPARATOR__ := \\
else
	__PATH_SEPARATOR__ := /
endif


## Obtain directory path that this Makefile lives in
ROOT_DIRECTORY_PATH := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
ROOT_DIRECTORY_NAME := $(notdir $(patsubst %$(__PATH_SEPARATOR__),%,$(ROOT_DIRECTORY_PATH)))


#
#    Override variables via optional configuration file
#
CONFIG_PATH := $(call path_append, $(ROOT_DIRECTORY_PATH), .make-config)
ifneq ("$(wildcard $(CONFIG_PATH))", "")
	include $(CONFIG_PATH)
endif


#
#    Make variables built from components
#
MAKE_PATH := $(call path_append, $(ROOT_DIRECTORY_PATH), Makefile)

SCRIPT__SOURCE_PATH := $(call path_append, $(ROOT_DIRECTORY_PATH), $(SCRIPT_NAME))
SCRIPT__INSTALL_PATH := $(call path_append, $(INSTALL_DIRECTORY), $(SCRIPT_NAME))

MAN__SOURCE_DIR := $(call path_append, $(ROOT_DIRECTORY_PATH), $(MAN_DIR_NAME))
MAN__INSTALL_DIR := $(call path_append, $(MAN_PATH), $(MAN_DIR_NAME))

GIT_MODULES_PATH := $(call path_append, $(ROOT_DIRECTORY_PATH), .gitmodules)


#
#    Make targets and settings
#
.ONESHELL: install

.PHONY: clean
.SILENT: clean
clean: SHELL := /bin/bash
clean: ## Removes configuration file
	[[ -f "$(CONFIG_PATH)" ]] && {
		rm -v "$(CONFIG_PATH)"
	}

.PHONY: config
.SILENT: config
config: SHELL := /bin/bash
config: ## Writes configuration file
	tee "$(CONFIG_PATH)" 1>/dev/null <<EOF
	SCRIPT_NAME = $(SCRIPT_NAME)
	INSTALL_DIRECTORY = $(INSTALL_DIRECTORY)
	__OS__ = $(__OS__)
	__PATH_SEPARATOR__ = $(__PATH_SEPARATOR__)
	MAN_PATH = $(MAN_PATH)
	MAN_DIR_NAME = $(MAN_DIR_NAME)
	GIT_BRANCH = $(GIT_BRANCH)
	GIT_REMOTE = $(GIT_REMOTE)
	EOF

.PHONY: install
.SILENT: install
install: ## Runs targets -> link-script link-manual
install: | link-script link-manual

.PHONY: uninstall
.SILENT: uninstall
uninstall: ## Runs targets -> unlink-script unlink-manual
uninstall: | unlink-script unlink-manual

.PHONY: upgrade
.SILENT: upgrade
upgrade: ## Runs targets -> uninstall git-pull install
upgrade: | uninstall git-pull install

.PHONY: git-pull
.SILENT: git-pull
git-pull: SHELL := /bin/bash
git-pull: ## Pulls updates from default upstream Git remote
	cd "$(ROOT_DIRECTORY_PATH)"
	git pull $(GIT_REMOTE) $(GIT_BRANCH)
	[[ -f "$(GIT_MODULES_PATH)" ]] && {
		git submodule update --init --merge --recursive
	}

.PHONY: link-script
.SILENT: link-script
link-script: SHELL := /bin/bash
link-script: ## Symbolically links to project script
	if [[ -L "$(SCRIPT__INSTALL_PATH)" ]]; then
		printf >&2 'Link already exists -> %s\n' "$(SCRIPT__INSTALL_PATH)"
	elif [[ -f "$(SCRIPT__INSTALL_PATH)" ]]; then
		printf >&2 'Error link target is a file -> %s\n' "$(SCRIPT__INSTALL_PATH)"
	else
		ln -sv "$(SCRIPT__SOURCE_PATH)" "$(SCRIPT__INSTALL_PATH)"
	fi

.PHONY: unlink-script
.SILENT: unlink-script
unlink-script: SHELL := /bin/bash
unlink-script: ## Removes symbolic links to project script
	if [[ -L "$(SCRIPT__INSTALL_PATH)" ]]; then
		rm -v "$(SCRIPT__INSTALL_PATH)"
	elif [[ -f "$(SCRIPT__INSTALL_PATH)" ]]; then
		printf >&2 'Error link target is a file -> %s\n' "$(SCRIPT__INSTALL_PATH)"
	else
		printf >&2 'No link to remove at -> %s\n' "$(SCRIPT__INSTALL_PATH)"
	fi

.PHONY: man
.SILENT: man
man: SHELL := /bin/bash
man: ## Builds manual pages via `help2man` command
	if [[ -d "$(MAN__SOURCE_DIR)" ]]; then
		help2man "$(SCRIPT__SOURCE_PATH)" --output="$(call path_append, $(MAN__SOURCE_DIR), $(NAME)).1" --no-info
	fi

.PHONY: link-manual
.SILENT: link-manual
link-manual: SHELL := /bin/bash
link-manual: ## Symbolically links project manual page(s)
	if ! [[ -d "$(MAN__SOURCE_DIR)" ]]; then
		printf >&2 'No manual entries found at -> %s\n' "$(MAN__SOURCE_DIR)"
		exit 0
	fi
	while read -r _page; do
		if [[ -L "$(MAN__INSTALL_DIR)$(__PATH_SEPARATOR__)$${_page}" ]]; then
			printf >&2 'Link already exists -> %s\n' "$(MAN__INSTALL_DIR)$(__PATH_SEPARATOR__)$${_page}"
		else
			ln -sv "$(MAN__SOURCE_DIR)$(__PATH_SEPARATOR__)$${_page}" "$(MAN__INSTALL_DIR)$(__PATH_SEPARATOR__)$${_page}"
		fi
	done < <(ls "$(MAN__SOURCE_DIR)")

.PHONY: unlink-manual
.SILENT: unlink-manual
unlink-manual: SHELL := /bin/bash
unlink-manual: ## Removes symbolic links to project manual page(s)
	if ! [[ -d "$(MAN__SOURCE_DIR)" ]]; then
		printf >&2 'No manual entries found at -> %s\n' "$(MAN__SOURCE_DIR)"
		exit 0
	fi
	while read -r _page; do
		if [[ -L "$(MAN__INSTALL_DIR)$(__PATH_SEPARATOR__)$${_page}" ]]; then
			rm -v "$(MAN__INSTALL_DIR)$(__PATH_SEPARATOR__)$${_page}"
		else
			printf >&2 'No manual page found at -> %s\n' "$(MAN__INSTALL_DIR)$(__PATH_SEPARATOR__)$${_page}"
		fi
	done < <(ls "$(MAN__SOURCE_DIR)")

.PHONY: list
.SILENT: list
list: SHELL := /bin/bash
list: ## Lists available make commands
	gawk 'BEGIN {
		delete matched_lines
	}
	{
		if ($$0 ~ "^[a-z0-9A-Z-]{1,32}: [#]{1,2}[[:print:]]*$$") {
			matched_lines[length(matched_lines)] = $$0
		}
	}
	END {
		print "## Make Commands for $(NAME) ##\n"
		for (k in matched_lines) {
			split(matched_lines[k], line_components, ":")
			gsub(" ## ", "    ", line_components[2])
			print line_components[1]
			print line_components[2]
			if ((k + 1) != length(matched_lines)) {
				print
			}
		}
	}' "$(MAKE_PATH)"

