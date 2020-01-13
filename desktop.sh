#!/usr/bin/bash
# Base {{{
sudo apt install -y flatpak openvpn docker.io xclip xfce4-terminal
# }}}
# Flatpak packages {{{
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub --user -y \
	telegram \
	fondo \
	spotify \
	org.gnome.Boxes \
	io.dbeaver.DBeaverCommunity

# }}}
# Gnome setup {{{
dconf load  / < optional/dconf.conf
# }}}

# vim:foldmethod=marker:foldlevel=0
