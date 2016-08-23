# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/ibutils/ibutils-1.5.7-r3.ebuild,v 1.1 2014/04/16 08:22:29 alexxy Exp $

EAPI="5"

OFED_VER="3.18"
OFED_RC="1"
OFED_RC_VER="2"
OFED_SUFFIX="0.2.gbd7e502"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="OpenIB userspace tools"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-infiniband/libibverbs:${SLOT}
		=dev-lang/tk-8.5.17
        media-gfx/graphviz[tcl]"
RDEPEND="${DEPEND}
		!sys-infiniband/openib-userspace"

block_other_ofed_versions
