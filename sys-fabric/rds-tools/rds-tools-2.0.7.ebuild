# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="1.16"

inherit openib toolchain-funcs

DESCRIPTION="OpenIB userspace rds-tools"

KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fabric/libibverbs:${SLOT}"
RDEPEND="${DEPEND}
	!sys-fabric/openib-userspace"

block_other_ofed_versions

DOCS=( README )
PATCHES=( "${FILESDIR}"/${P}-qa.patch )

pkg_setup() {
	tc-export CC
}
