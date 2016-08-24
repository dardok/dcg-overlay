# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fabric/libmthca/libmthca-1.0.6.ebuild,v 1.1 2014/04/16 08:22:22 alexxy Exp $

EAPI="5"

OFED_VER="3.18"
OFED_RC="1"
OFED_RC_VER="3"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB userspace driver for Mellanox InfiniBand HCAs"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fabric/libibverbs:${SLOT}"
RDEPEND="${DEPEND}
		!sys-fabric/openib-userspace"
block_other_ofed_versions
