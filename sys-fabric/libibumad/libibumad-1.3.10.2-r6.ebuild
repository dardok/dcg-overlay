# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fabric/libibumad/libibumad-1.3.9.ebuild,v 1.2 2014/08/10 20:18:51 slyfox Exp $

EAPI="5"

OFED_VER="3.18-3"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="1.3.10.2"

inherit openib

DESCRIPTION="OpenIB User MAD library functions which sit on top of the user MAD modules in the kernel"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-fabric/libibverbs:${SLOT}
	"
RDEPEND="${DEPEND}"
block_other_ofed_versions
