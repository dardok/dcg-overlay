# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils

DESCRIPTION="OpenIB userspace RDMA CM library"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="+utils static-libs"

DEPEND="sys-fabric/libibverbs:${SLOT}"
RDEPEND="${DEPEND}"

block_other_ofed_versions

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile rdmacm

	if use utils; then
		cmake-utils_src_compile \
			cmtime \
			mckey \
			rcopy \
			rdma_client \
			rdma_server \
			rdma_xclient \
			rdma_xserver \
			riostream \
			rping \
			rstream \
			ucmatose \
			udaddy \
			udpong
	fi
}

src_install() {
	insinto /usr/include/rdma
	doins ${S}/librdmacm/rdma_cma.h
	doins ${S}/librdmacm/rdma_cma_abi.h
	doins ${S}/librdmacm/rdma_verbs.h
	doins ${S}/librdmacm/rsocket.h

	dodoc ${S}/Documentation/librdmacm.md

	dolib.so ${BUILD_DIR}/lib/librdmacm.so*

	doman ${S}/librdmacm/man/rdma_*.3

	if use utils; then
		dobin ${BUILD_DIR}/bin/*

		doman ${S}/librdmacm/man/*.1
	fi
}
