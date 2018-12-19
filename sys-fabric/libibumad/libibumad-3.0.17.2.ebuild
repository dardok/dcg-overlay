# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC="1"
OFED_RC_VER="1"
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils

DESCRIPTION="OpenIB User MAD library functions which sit on top of the user MAD modules in the kernel"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

block_other_ofed_versions

src_compile() {
	cmake-utils_src_compile ibumad
}

src_install() {
	insinto /usr/include/infiniband
	doins ${S}/libibumad/*.h

	dolib.so ${BUILD_DIR}/lib/libibumad.so*

	doman ${S}/libibumad/man/umad_*.3
	newman ${S}/libibumad/man/umad_init.3 umad_done.3
	newman ${S}/libibumad/man/umad_class_str.3 umad_attribute_str.3
	newman ${S}/libibumad/man/umad_class_str.3 umad_method_str.3
	newman ${S}/libibumad/man/umad_class_str.3 umad_status_str.3
	newman ${S}/libibumad/man/umad_get_ca.3 umad_release_ca.3
	newman ${S}/libibumad/man/umad_get_port.3 umad_release_port.3
}
