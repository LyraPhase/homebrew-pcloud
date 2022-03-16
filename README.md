<!-- markdownlint-configure-file
{
  "required-headings": {
    "headings": [
      "# homebrew-pcloud",
      "*",
      "## Installation",
      "*",
      "## Usage",
      "*",
      "## Sponsor",
      "*",
      "## Migration",
      "*",
      "## Development",
      "*",
      "## Testing",
      "*",
      "## Credits",
      "*"
    ]
  }
}
-->

# homebrew-pcloud

[![ci](https://github.com/LyraPhase/sprout-wrap/actions/workflows/ci.yml/badge.svg)](https://github.com/LyraPhase/sprout-wrap/actions/workflows/ci.yml)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![pre-commit](https://github.com/LyraPhase/sprout-wrap/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/LyraPhase/sprout-wrap/actions/workflows/pre-commit.yml)
[![Donate using Liberapay](https://liberapay.com/assets/widgets/donate.svg)](https://liberapay.com/trinitronx/donate)

Install pCloud Drive via Homebrew

Since this recipe was rejected from Homebrew because of the volatile nature of
pCloud links (see [homebrew-cask#57634](https://github.com/Homebrew/homebrew-cask/pull/57634))
we will try to maintain this because it is useful to us and might be for others.
:smile:

## Installation

First, make sure you have installed [`homebrew`](https://brew.sh) and
[`homebrew-cask`](http://caskroom.io/) if you haven't yet.

Then, run the following in your command-line:

    brew tap lyraphase/pcloud

## Usage

**Note**: For info run:

    brew info --cask pcloud-drive

Once the tap is installed, you can install `pcloud-drive`!

    brew install --cask pcloud-drive

To uninstall run:

    brew uninstall --cask pcloud-drive

## Sponsor

If you find this project useful and appreciate my work,
would you be willing to click one of the buttons below to Sponsor this project
and help me continue?

<!-- markdownlint-disable MD013  -->
| Method   | Button                                                                                                                 |
| :------- | :--------------------------------------------------------------------------------------------------------------------: |
| GitHub   | [💖 Sponsor](https://github.com/sponsors/trinitronx)                                                                   |
| Liberapay| [![Donate using Liberapay](https://liberapay.com/assets/widgets/donate.svg)](https://liberapay.com/trinitronx/donate)  |
| PayPal   | [![Donate with PayPal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/JamesCuzella) |
<!-- markdownlint-enable MD013  -->

Every little bit is appreciated! Thank you! 🙏

## Migration

**Note:** This Homebrew Tap has migrated from the old location
(`trinitronx/homebrew-pcloud`) to `lyraphase/pcloud`. It has **NOT** changed
ownership or maintainers at this time. It has been moved to benefit from
GitHub's CI/CD automation features that are available to a GitHub Organization.

While all links to the previous repository location are automatically redirected
to the new location by GitHub, it is recommended to migrate this Tap and any
previously cloned `git` repos to use the new URL.
To avoid confusion, we strongly recommend updating any existing local clones to
point to the new repository URL.

You can do this easily using Homebrew commands:

    brew uninstall --cask pcloud-drive
    brew untap trinitronx/pcloud
    brew tap lyraphase/pcloud
    brew install --cask pcloud-drive

Alternatively, you can also do this by using git remote on the command line:
This method does not require that you uninstall the `pcloud-drive` Cask.

    cd $(brew --repo)/Library/Taps/trinitronx/homebrew-pcloud
    git remote -vv  # List remote repos
    # Find the named remote URL with 'trinitronx/homebrew-pcloud'
    # (usually 'origin' by default)
    # If you checked this repo out as a fork
    # or named the remote repo something other than 'origin',
    # then use that in the following command
    git remote set-url origin https://github.com/LyraPhase/homebrew-pcloud.git
    git remote -vv  # Check that the remote repo URL now contains 'LyraPhase/homebrew-pcloud'
    # Move the directory to the new naming format
    cd $(brew --repo)/Library/Taps/
    mv trinitronx lyraphase

## Development

If you wish to contribute to this Cask, there is a helper `Makefile` with some
useful targets.

To checkout this repo and install in development mode:

    git clone https://github.com/lyraphase/homebrew-pcloud.git
    cd homebrew-pcloud
    make install

This will install a symbolic link to this git repo under:

    $(brew --repo)/Library/Taps/lyraphase/homebrew-pcloud

Then, you may edit and test the Homebrew Cask recipe from the cloned git repo
file location.

## Testing

To test:

    make test

## Credits

The base formula comes from [gist.github.com/tomgross/bae4f3002327][1]

[1]: https://gist.github.com/tomgross/bae4f30023272d8c8c0d920b62720c6b
