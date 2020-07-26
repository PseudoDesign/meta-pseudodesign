# meta-pseudodesign

## Recipes

### recipes-connectivity

#### openssh

Adds pseudodesign's public ssh keys to authorized keys

### recipes-core

#### base-files (append)

Adds the logo ascii image to `/etc/issue`.

#### Images

##### pseudodesign-dev-image

Creates the development image for the pseudodesign distro

#### nvmfs

Fills the remainder of the main flash memory device with an NVM partition at `/dev/mmcblk0p4`.

#### systemd

#### wpa-supplicant

Add a wifi network to WPA supplicant, and configure it to run on startup.

Uses the following variables, which should be defined in your `local.conf`

```
PSEUDODESIGN_WIFI_SSID - SSID of the network to join by default
PSEUDODESIGN_WIFI_PSK - wpa_passphrase*-encoded key of the network you wish to join (be sure not to check this in to your repo)
PSEUDODESIGN_WIFI_INTERFACE - network interface to use for wifi
```
*See the [wpa_passphrase](https://www.linux.org/docs/man8/wpa_passphrase.html) documentation for details.

### recipes-support

#### vim

Update `vimrc` to disable cursor support.

