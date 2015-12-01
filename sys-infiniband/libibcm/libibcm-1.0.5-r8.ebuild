# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/libibcm/libibcm-1.0.5-r3.ebuild,v 1.1 2014/04/16 08:22:25 alexxy Exp $

EAPI="5"

OFED_VER="3.18-1"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB Userspace CM library"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

RDEPEND="sys-infiniband/libibverbs:${SLOT}"
DEPEND="${RDEPEND}"
block_other_ofed_versions
