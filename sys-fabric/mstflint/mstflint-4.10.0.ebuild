# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
OFED_SUFFIX="3"

inherit openib

DESCRIPTION="Mellanox firmware burning application"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="+dc +inband +cs openssl xml"

DEPEND="dc? ( sys-libs/zlib )
		inband? ( sys-fabric/infiniband-diags:${SLOT} )
		cs? ( dev-libs/openssl )
		openssl? ( dev-libs/openssl )
		xml? ( dev-libs/libxml2 )
		"
RDEPEND="${DEPEND}"

block_other_ofed_versions

PATCHES=( "${FILESDIR}"/openssl-hmac.patch )

src_configure () {
	econf \
		$(use_enable cs) \
		$(use_enable inband) \
		$(use_enable dc) \
		$(use_enable openssl) \
		$(use_enable xml xml2)
}
