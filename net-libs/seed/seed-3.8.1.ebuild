# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils

DESCRIPTION="Seed is a library and interpreter, dynamically bridging (through GObjectIntrospection) the WebKit JavaScriptCore engine, with the GNOME platform."
HOMEPAGE="https://wiki.gnome.org/action/show/Projects/Seed"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/seed/3.8/seed-3.8.1.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"
IUSE="+X +cairo +sqlite"

RDEPEND="
  cairo? ( x11-libs/cairo )
  sqlite? ( dev-db/sqlite )"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		$(use_enable X xorg-module ) \
		$(use_enable cairo cairo-module ) \
		$(use_enable sqlite sqlite-module )
}
