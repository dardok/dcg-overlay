# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fabric/perftest/perftest-2.0.ebuild,v 1.1 2014/04/16 08:22:29 alexxy Exp $

EAPI="5"

OFED_VER="3.18"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="0.9.g214990b"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="OpenIB uverbs micro-benchmarks"

KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-fabric/libibverbs:${SLOT}
	sys-fabric/libibumad:${SLOT}
	sys-fabric/librdmacm:${SLOT}"
RDEPEND="${DEPEND}"
block_other_ofed_versions

src_install() {
	dodoc README runme
	dobin ib_*
}
