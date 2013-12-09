# Asterisk cookbook

This Chef cookbook installs Asterisk either from source or packages and configures its basic settings. It also optionally installs the UniMRCP module. It is intended that this cookbook remain small and perform only installation tasks, with downstream cookbooks depending on it to configure Asterisk for more specific tasks.

# Requirements

Tested on Ubuntu 12.04, Debian 7.1 and CentOS 6.5.

# Usage

Add `recipe[asterisk]` to your node's run list. Optionally add `recipe[asterisk::unimrcp]`.

# Attributes



# Recipes

* `asterisk` - Fetches and installs Asterisk
* `asterisk::unimrcp` - Fetches and installs mod_unimrcp

# Author

[Ben Langfeld](@benlangfeld)

