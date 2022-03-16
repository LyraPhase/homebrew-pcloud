# homebrew-pcloud

[![ci](https://github.com/LyraPhase/sprout-wrap/actions/workflows/ci.yml/badge.svg)](https://github.com/LyraPhase/sprout-wrap/actions/workflows/ci.yml)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![pre-commit](https://github.com/LyraPhase/sprout-wrap/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/LyraPhase/sprout-wrap/actions/workflows/pre-commit.yml)
<noscript><a href="https://liberapay.com/trinitronx/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a></noscript>

Install pCloud Drive via Homebrew

Since this recipe was rejected from Homebrew because of the volatile nature of pCloud links (see [homebrew-cask#57634](https://github.com/Homebrew/homebrew-cask/pull/57634)) we will try to maintain this because it is useful to us and might be for others. :smile:

## Installation

First, make sure you have installed [`homebrew`](https://brew.sh) and [`homebrew-cask`](http://caskroom.io/) if you haven't yet.

Then, run the following in your command-line:

    brew tap trinitronx/homebrew-pcloud

## Usage

**Note**: For info run:

    brew info --cask pcloud-drive

Once the tap is installed, you can install `pcloud-drive`!

    brew install --cask pcloud-drive

To uninstall run:

    brew uninstall --cask pcloud-drive

## Sponsor

If you find this project useful and appreciate my work,
would you be willing to click one of the buttons below to Sponsor this project and help me continue?

- <noscript><a href="https://github.com/sponsors/trinitronx">:heart: Sponsor</a></noscript>
- <noscript><a href="https://liberapay.com/trinitronx/donate"><img alt="Donate using Liberapay" src="https://liberapay.com/assets/widgets/donate.svg"></a></noscript>
- <noscript><a href="https://paypal.me/JamesCuzella"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" alt="Donate with PayPal" /></a></noscript>

Every little bit is appreciated! Thank you! 🙏


## Development

If you wish to contribute to this Cask, there is a helper `Makefile` with some useful targets.

To checkout this repo and install in development mode:

    git clone https://github.com/trinitronx/homebrew-pcloud.git
    cd homebrew-pcloud
    make install

This will install a symbolic link to this git repo under: `$(brew --repo)/Library/Taps/trinitronx/homebrew-pcloud`

Then, you may edit and test the Homebrew Cask recipe from the cloned git repo file location.

## Testing

To test:

    make test

## Credits

The base formula comes from [gist.github.com/tomgross/bae4f3002327][1]

[1]: https://gist.github.com/tomgross/bae4f30023272d8c8c0d920b62720c6b
