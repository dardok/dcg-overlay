# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC="1"
OFED_RC_VER="1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="Measure RDMA and IP performance"
KEYWORDS="amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-fabric/libibverbs:${SLOT}
	sys-fabric/librdmacm:${SLOT}
	"
RDEPEND="
		!sys-fabric/openib-userspace"
block_other_ofed_versions
