# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC="1"
OFED_RC_VER="1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="The IB Proxy Daemon (ibpd) is a user-mode process for infiniband proxy devices."
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fabric/libibumad:${SLOT}
		sys-fabric/libibverbs:${SLOT}
		"
RDEPEND="${DEPEND}
		sys-apps/systemd
		sys-fabric/rdma-core:${SLOT}
		"

block_other_ofed_versions
