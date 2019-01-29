# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils

DESCRIPTION="libmlx5"
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
	cmake-utils_src_compile mlx5
}

src_install() {
	insinto /etc/libibverbs.d
	doins ${BUILD_DIR}/providers/mlx5/mlx5.driver

	dolib.so ${BUILD_DIR}/lib/libmlx5.so*

	dosym ../libmlx5.so ${EPREFIX}/usr/$(get_libdir)/libibverbs/libmlx5-rdmav${LIBVER}.so

	insinto /usr/include/infiniband
	doins ${S}/providers/mlx5/mlx5dv.h

	doman ${S}/providers/mlx5/man/*.{3,7}
}
