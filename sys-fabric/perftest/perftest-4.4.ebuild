# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="0.5.g1ceab48"

inherit openib

DESCRIPTION="gen3 uverbs micro-benchmarks"

KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fabric/libibverbs:${SLOT}
		sys-fabric/libibumad:${SLOT}
		sys-fabric/librdmacm:${SLOT}"
RDEPEND="${DEPEND}"

block_other_ofed_versions

src_install() {
	dodoc README COPYING runme
	dobin ib_* raw_*
}
