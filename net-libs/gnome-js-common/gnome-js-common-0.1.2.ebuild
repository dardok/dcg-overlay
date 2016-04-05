# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="GNOME JS COMMON"
HOMEPAGE="https://github.com/GNOME/gnome-js-common"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/gnome-js-common/0.1/gnome-js-common-0.1.2.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"
IUSE="+seed"

RDEPEND="
	seed? ( net-libs/seed )"
DEPEND="${RDEPEND}"
