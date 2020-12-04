# Generate Random Password
[heading__top]:
  #generate-random-password
  "&#x2B06; Generates random passphrase of given length"


Generates random passphrase of given length


## [![Byte size of Generate Random Password][badge__main__generate_random_password__source_code]][generate_random_password__main__source_code] [![Open Issues][badge__issues__generate_random_password]][issues__generate_random_password] [![Open Pull Requests][badge__pull_requests__generate_random_password]][pull_requests__generate_random_password] [![Latest commits][badge__commits__generate_random_password__main]][commits__generate_random_password__main] [![Build Status][badge_travis_ci]][build_travis_ci]


---


- [:arrow_up: Top of Document][heading__top]

- [:building_construction: Requirements][heading__requirements]

- [:zap: Quick Start][heading__quick_start]

  - [:floppy_disk: Clone][heading__clone]
  - [:heavy_plus_sign: Install][heading__install]
  - [:fire: Uninstall][heading__uninstall]
  - [:arrow_up: Upgrade][heading__upgrade]
  - [:bookmark_tabs: Documentation][heading__documentation]

- [&#x1F9F0; Usage][heading__usage]

- [&#x1F5D2; Notes][heading__notes]

- [:chart_with_upwards_trend: Contributing][heading__contributing]

  - [:trident: Forking][heading__forking]
  - [:currency_exchange: Sponsor][heading__sponsor]

- [:card_index: Attribution][heading__attribution]

- [:balance_scale: Licensing][heading__license]


---



## Requirements
[heading__requirements]:
  #requirements
  "&#x1F3D7; Prerequisites and/or dependencies that this project needs to function properly"


This repository depends upon `git`, `head`, `tr`, and `printf` command-line utilities, please use the package manager for your distribution to install these dependencies, eg...

- Arch based Operating Systems


```Bash
sudo packman -Syy

sudo packman -S coreutils git make
```


- Debian derived Operating Systems...


```Bash
sudo apt-get install coreutils git make
```


Additionally this project makes use of Git Submodules to track Bash script dependencies, to avoid incomplete downloads clone with the `--recurse-submodules` option...


```Bash
git clone --recurse-submodules git@github.com:paranoid-linux/generate-random-password.git
```


After cloning to update tracked Git Submodules issue the following commands...


```Bash
git pull

git submodule update --init --merge --recursive
```


To force upgrade of Git Submodules...


```Bash
git submodule update --init --merge --recursive --remote
```


> Note, forcing and update of Git Submodule tracked dependencies may cause instabilities and/or merge conflicts; if however everything operates as expected after an update please consider submitting a Pull Request.


______


## Quick Start
[heading__quick_start]:
  #quick-start
  "&#9889; Perhaps as easy as one, 2.0,..."


> Perhaps as easy as one, 2.0,...


---


### Clone
[heading__clone]:
  #clone
  "&#x1f4be;"


Clone this project...


```Bash
mkdir -vp ~/git/hub/paranoid-linux

cd ~/git/hub/paranoid-linux

git clone --recurse-submodules git@github.com:paranoid-linux/generate-random-password.git
```


---


### Install
[heading__install]:
  #install
  "&#x2795;"


If **not** using a plugin manager, then this plugin may be installed via `make install` command...


```Bash
cd ~/git/hub/paranoid-linux/generate-random-password

make install
```


---


### Uninstall
[heading__uninstall]:
  #uninstall
  "&#x1f525;"


If not using a plugin manager, then this plugin may be uninstalled via `uninstall` Make target...


```Bash
cd ~/git/hub/paranoid-linux/generate-random-password

make uninstall
```


... Which will remove symbolic links and update the Vim help tags file.


---


### Upgrade
[heading__upgrade]:
  #upgrade
  "&#x2b06;"


To update in the future use `make upgrade` command...


```Bash
cd ~/git/hub/paranoid-linux/generate-random-password

make upgrade
```


---


### Documentation
[heading__documentation]:
  #documentation
  "&#x1F4D1;"


After installation, plugin documentation may be accessed via Vim's `man` command...


```Bash
man generate-random-password
```


... or, via `--help` parameter...


```Bash
generate-random-password --help
```


______


## Usage
[heading__usage]:
  #usage
  "&#x1F9F0; How to utilize this repository"


Provide minimum character length for random password to generate...


```Bash
generate-random-password 32
#> LUy+c99K(t$sF I9XG"?.$8l/=Ld]xwT
```


Or supply minimum and maximum range of characters...


```Bash
generate-random-password 32 42
#> gbMCn>cC^OzF1/!9`sx0h|@9&f}YZ?B?4<+m(v>&XE
```


... which generates a random password between min/max values; inclusively.


______


## Notes
[heading__notes]:
  #notes
  "&#x1F5D2; Additional things to keep in mind when developing"


This repository may not be feature complete and/or fully functional, Pull Requests that add features or fix bugs are certainly welcomed.


______


## Contributing
[heading__contributing]:
  #contributing
  "&#x1F4C8; Options for contributing to generate-random-password and paranoid-linux"


Options for contributing to generate-random-password and paranoid-linux


---


### Forking
[heading__forking]:
  #forking
  "&#x1F531; Tips for forking generate-random-password"


Start making a [Fork][generate_random_password__fork_it] of this repository to an account that you have write permissions for.


- Add remote for fork URL. The URL syntax is _`git@github.com:<NAME>/<REPO>.git`_...


```Bash
cd ~/git/hub/paranoid-linux/generate-random-password

git remote add fork git@github.com:<NAME>/generate-random-password.git
```


- Commit your changes and push to your fork, eg. to fix an issue...


```Bash
cd ~/git/hub/paranoid-linux/generate-random-password


git commit -F- <<'EOF'
:bug: Fixes #42 Issue


**Edits**


- `<SCRIPT-NAME>` script, fixes some bug reported in issue
EOF


git push fork main
```


> Note, the `-u` option may be used to set `fork` as the default remote, eg. _`git push fork main`_ however, this will also default the `fork` remote for pulling from too! Meaning that pulling updates from `origin` must be done explicitly, eg. _`git pull origin main`_


- Then on GitHub submit a Pull Request through the Web-UI, the URL syntax is _`https://github.com/<NAME>/<REPO>/pull/new/<BRANCH>`_


> Note; to decrease the chances of your Pull Request needing modifications before being accepted, please check the [dot-github](https://github.com/paranoid-linux/.github) repository for detailed contributing guidelines.


---


### Sponsor
  [heading__sponsor]:
  #sponsor
  "&#x1F4B1; Methods for financially supporting paranoid-linux that maintains generate-random-password"


Thanks for even considering it!


With [![sponsor__shields_io__liberapay]][sponsor__link__liberapay] you may sponsor paranoid-linux on a repeating basis.


Regardless of if you're able to financially support projects such as `generate-random-password` that `paranoid-linux` maintains, please consider sharing projects that are useful with others, because one of the goals of maintaining Open Source repositories is to provide value to the community.


______


## Attribution
[heading__attribution]:
  #attribution
  "&#x1F4C7; Resources that where helpful in building this project so far."


- [GitHub -- `github-utilities/make-readme`](https://github.com/github-utilities/make-readme)

- [Unix StackExchange -- How to generate a random string?](https://unix.stackexchange.com/questions/230673/)

- [StackOverflow -- How to generate random number in Bash?](https://stackoverflow.com/questions/1194882/)


______


## License
[heading__license]:
  #license
  "&#x2696; Legal side of Open Source"


```
Documentation for generating random passphrase of given length
Copyright (C) 2020 S0AndS0

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


For further details review full length version of [AGPL-3.0][branch__current__license] License.



[branch__current__license]:
  /LICENSE
  "&#x2696; Full length version of AGPL-3.0 License"


[badge__commits__generate_random_password__main]:
  https://img.shields.io/github/last-commit/paranoid-linux/generate-random-password/main.svg

[commits__generate_random_password__main]:
  https://github.com/paranoid-linux/generate-random-password/commits/main
  "&#x1F4DD; History of changes on this branch"


[generate_random_password__community]:
  https://github.com/paranoid-linux/generate-random-password/community
  "&#x1F331; Dedicated to functioning code"


[issues__generate_random_password]:
  https://github.com/paranoid-linux/generate-random-password/issues
  "&#x2622; Search for and _bump_ existing issues or open new issues for project maintainer to address."

[generate_random_password__fork_it]:
  https://github.com/paranoid-linux/generate-random-password/
  "&#x1F531; Fork it!"

[pull_requests__generate_random_password]:
  https://github.com/paranoid-linux/generate-random-password/pulls
  "&#x1F3D7; Pull Request friendly, though please check the Community guidelines"

[generate_random_password__main__source_code]:
  https://github.com/paranoid-linux/generate-random-password/
  "&#x2328; Project source!"

[badge__issues__generate_random_password]:
  https://img.shields.io/github/issues/paranoid-linux/generate-random-password.svg

[badge__pull_requests__generate_random_password]:
  https://img.shields.io/github/issues-pr/paranoid-linux/generate-random-password.svg

[badge__main__generate_random_password__source_code]:
  https://img.shields.io/github/repo-size/paranoid-linux/generate-random-password


[sponsor__shields_io__liberapay]:
  https://img.shields.io/static/v1?logo=liberapay&label=Sponsor&message=paranoid-linux

[sponsor__link__liberapay]:
  https://liberapay.com/paranoid-linux
  "&#x1F4B1; Sponsor developments and projects that paranoid-linux maintains via Liberapay"


[badge_travis_ci]:
  https://travis-ci.com/paranoid-linux/generate-random-password.svg?branch=main

[build_travis_ci]:
  https://travis-ci.com/paranoid-linux/generate-random-password

