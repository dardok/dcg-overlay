# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools

DESCRIPTION="Seed is a library and interpreter, dynamically bridging (through GObjectIntrospection) the WebKit JavaScriptCore engine, with the GNOME platform."
HOMEPAGE="https://wiki.gnome.org/action/show/Projects/Seed"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.gnome.org/seed"
	EGIT_BRANCH="master"
	WEBKIT_SLOT=4
else
	SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/seed/3.8/seed-3.8.1.tar.xz"
	WEBKIT_SLOT=3
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"
IUSE="+X +cairo +sqlite"

RDEPEND="
	net-libs/webkit-gtk:${WEBKIT_SLOT}
	cairo? ( x11-libs/cairo )
	sqlite? ( dev-db/sqlite )"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	dev-util/gtk-doc"

src_prepare() {
    NOCONFIGURE=1 ./autogen.sh || die "autogen failed"
}

src_configure() {
	econf \
		$(use_enable X xorg-module ) \
		$(use_enable cairo cairo-module ) \
		$(use_enable sqlite sqlite-module )
}
