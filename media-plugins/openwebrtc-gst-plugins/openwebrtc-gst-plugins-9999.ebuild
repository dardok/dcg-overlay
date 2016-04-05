# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools git-r3

DESCRIPTION="OpenWebRTC specific GStreamer plugins"
HOMEPAGE="https://github.com/EricssonResearch/openwebrtc-gst-plugins"

EGIT_REPO_URI="https://github.com/EricssonResearch/openwebrtc-gst-plugins.git"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"

RDEPEND="
	media-libs/gstreamer:1.0
	net-libs/usrsctp"
DEPEND="${RDEPEND}"

src_prepare() {
    ./autogen.sh || die "autogen failed"
}
