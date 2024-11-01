### Setup Procedure

1. Download a binary from [here](https://github.com/xremap/xremap/releases) and put it in `~/.local/bin/`.
2. Follow the instructions [here](https://github.com/kmonad/kmonad/blob/master/doc/faq.md#q-how-do-i-get-uinput-permissions) and then reboot the system.
3. Enable the systemd service by:
   1. Copy the unit file to `~/.config/systemd/user/`.
   2. Run `$ systemctl --user daemon-reload`.
   3. Run `$ systemctl --user start xremap`.
   4. Run `$ systemctl --user enable xremap`.
