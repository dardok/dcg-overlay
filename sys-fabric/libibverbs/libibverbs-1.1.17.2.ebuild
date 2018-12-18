# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC="1"
OFED_RC_VER="1"
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils

DESCRIPTION="A library allowing programs to use InfiniBand 'verbs' for direct access to IB hardware"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="+utils"

DEPEND="dev-libs/libnl:3"
RDEPEND="${DEPEND}"

block_other_ofed_versions

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile ibverbs

	if use utils; then
		cmake-utils_src_compile \
			ibv_asyncwatch \
			ibv_devices \
			ibv_devinfo \
			ibv_rc_pingpong \
			ibv_srq_pingpong \
			ibv_uc_pingpong \
			ibv_ud_pingpong \
			ibv_xsrq_pingpong
	fi
}

src_install() {
	insinto /usr/include/infiniband
	doins ${S}/ibacm/include/infiniband/acm.h
	doins ${S}/ibacm/include/infiniband/acm_prov.h
	doins ${S}/libibverbs/arch.h
	doins ${S}/libibverbs/driver.h
	doins ${S}/libibverbs/kern-abi.h
	doins ${S}/libibverbs/marshall.h
	doins ${S}/libibverbs/opcode.h
	doins ${S}/libibverbs/sa.h
	doins ${S}/libibverbs/sa-kern-abi.h
	doins ${S}/libibverbs/tm_types.h
	doins ${S}/libibverbs/verbs.h
	doins ${S}/librdmacm/ib.h

	dodoc ${S}/Documentation/libibverbs.md

	dolib.so ${BUILD_DIR}/lib/libibverbs.so*

	doman ${S}/libibverbs/man/ibv_*.3
	newman ${S}/libibverbs/man/ibv_rate_to_mbps.3 mbps_to_ibv_rate.3
	newman ${S}/libibverbs/man/ibv_rate_to_mult.3 mult_to_ibv_rate.3

	if use utils; then
		dobin ${BUILD_DIR}/bin/ibv_*

		doman ${S}/libibverbs/man/ibv_*.1
	fi
}
