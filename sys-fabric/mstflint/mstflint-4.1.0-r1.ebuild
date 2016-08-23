# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/mstflint/mstflint-3.5.0.ebuild,v 1.1 2014/04/16 08:22:26 alexxy Exp $

EAPI="5"

OFED_VER="3.18-1"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="1.46.gb1cdaf7"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="Mellanox firmware burning application"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-libs/zlib
	sys-infiniband/libibmad:${SLOT}
	"
RDEPEND="${DEPEND}"
block_other_ofed_versions
