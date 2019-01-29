# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils

DESCRIPTION="libmlx4"
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
	cmake-utils_src_compile mlx4
}

src_install() {
	insinto /etc/libibverbs.d
	doins ${BUILD_DIR}/providers/mlx4/mlx4.driver

	dolib.so ${BUILD_DIR}/lib/libmlx4.so*

	dosym ../libmlx4.so ${EPREFIX}/usr/$(get_libdir)/libibverbs/libmlx4-rdmav${LIBVER}.so

	insinto /lib/modprobe.d
	newins ${S}/redhat/rdma.mlx4.sys.modprobe libmlx4.conf

	insinto /etc/modprobe.d
	doins ${S}/providers/mlx4/mlx4.conf

	exeinto /usr/libexec
	newexe ${S}/redhat/rdma.mlx4-setup.sh mlx4-setup.sh

	insinto /etc/rdma
	newins redhat/rdma.mlx4.conf mlx4.conf

	insinto /usr/include/infiniband
	doins ${S}/providers/mlx4/mlx4dv.h

	doman ${S}/providers/mlx4/man/*.{3,7}
}
