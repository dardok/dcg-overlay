# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fabric/libmlx4/libmlx4-1.0.5.ebuild,v 1.2 2015/02/24 09:03:51 patrick Exp $

EAPI="5"

OFED_VER="3.18"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OpenIB userspace driver for Mellanox ConnectX HCA"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-fabric/libibverbs:${SLOT}
	"
RDEPEND="
		!sys-fabric/openib-userspace"
block_other_ofed_versions
