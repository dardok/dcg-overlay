# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils

DESCRIPTION="libocrdma"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fabric/libibverbs:${SLOT}"
RDEPEND="${DEPEND}"

block_other_ofed_versions

LIBVER=$(get_version_component_range 1 ${RDMA_CORE_VER})

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile ocrdma-rdmav${LIBVER}
}

src_install() {
	insinto /etc/libibverbs.d
	doins ${BUILD_DIR}/providers/ocrdma/ocrdma.driver

	insinto /usr/$(get_libdir)/libibverbs
	insopts -m0755
	doins ${BUILD_DIR}/lib/libocrdma-rdmav${LIBVER}.so
}
