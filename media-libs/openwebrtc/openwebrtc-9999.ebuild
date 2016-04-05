# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools git-r3

DESCRIPTION="OpenWebRTC"
HOMEPAGE="https://github.com/EricssonResearch/OpenWebRTC"

EGIT_REPO_URI="https://github.com/EricssonResearch/openwebrtc.git"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"
IUSE="static debug tests owr-static +owr-gst"

RDEPEND="
	media-sound/pulseaudio
	media-plugins/openwebrtc-gst-plugins
	dev-lang/orc
	dev-libs/json-glib
	net-libs/libnice
	net-libs/libsoup
	net-libs/seed
	owr-gst? ( media-libs/gstreamer:1.0 )"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	dev-util/gtk-doc"

src_prepare() {
    ./autogen.sh || die "autogen failed"
}

src_configure() {
	econf \
		$(use_enable static ) \
		$(use_enable debug ) \
		$(use_enable tests ) \
		$(use_enable owr-static ) \
		$(use_enable owr-gst )
}
