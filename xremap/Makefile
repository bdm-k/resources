all:
	sed "s|\$${HOME}|$$HOME|g" xremap.service.template > ~/.config/systemd/user/xremap.service
	systemctl --user daemon-reload
	systemctl --user start xremap
	systemctl --user enable xremap

.PHONY: all
