# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="2"

inherit openib

DESCRIPTION="OpenIB - Direct Access Provider Library"
KEYWORDS="amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fabric/libibverbs:${SLOT}
		sys-fabric/librdmacm:${SLOT}"
RDEPEND="${DEPEND}
		!sys-fabric/openib-userspace"

block_other_ofed_versions
