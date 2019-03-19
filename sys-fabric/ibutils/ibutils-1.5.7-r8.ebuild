# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fabric/ibutils/ibutils-1.5.7-r3.ebuild,v 1.1 2014/04/16 08:22:29 alexxy Exp $

EAPI="5"

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="0.2.gbd7e502"

inherit openib

DESCRIPTION="OpenIB userspace tools"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fabric/libibverbs:${SLOT}
		=dev-lang/tk-8.6.8
        media-gfx/graphviz[tcl]"
RDEPEND="${DEPEND}
		!sys-fabric/openib-userspace"

block_other_ofed_versions
