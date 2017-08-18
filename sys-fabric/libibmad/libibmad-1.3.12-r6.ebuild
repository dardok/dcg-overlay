# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fabric/libibmad/libibmad-1.3.9.ebuild,v 1.2 2012/10/13 06:48:22 alexxy Exp $

EAPI="4"

OFED_VER="3.18-3"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB library providing low layer IB functions for use by the IB diagnostic/management programs"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-fabric/libibumad:${SLOT}
	"
RDEPEND="${DEPEND}"
block_other_ofed_versions
