# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

if [[ $PV = *9999* ]]; then
    KEYWORDS=""
    EGIT_BRANCH="master"
fi

inherit eutils git-r3 autotools

DESCRIPTION="Headers defining the SPICE protocol"
HOMEPAGE="http://spice-space.org/"
#SRC_URI="http://spice-space.org/download/releases/${P}.tar.bz2"
EGIT_REPO_URI="git://anongit.freedesktop.org/spice/spice-protocol"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
    epatch_user
    if [[ ${PV} == 9999 ]]; then
        eautoreconf
    fi
}
