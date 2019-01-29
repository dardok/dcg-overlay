# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils systemd

DESCRIPTION="IB CM pre-connection service application"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fabric/libibumad:${SLOT}
		sys-fabric/libibverbs:${SLOT}
		"
RDEPEND="${DEPEND}
		sys-apps/systemd
		sys-fabric/rdma-core:${SLOT}
		"

block_other_ofed_versions

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile ibacm ibacmp ib_acme
}

src_install() {
	insinto /etc/rdma
	doins ${FILESDIR}/ibacm_opts.cfg

	insinto /usr/$(get_libdir)/ibacm
	doins ${BUILD_DIR}/lib/libibacmp.so

	dobin ${BUILD_DIR}/bin/ib_acme

	dosbin ${BUILD_DIR}/bin/ibacm

	sed -e "s^@CMAKE_INSTALL_FULL_SBINDIR@^${EPREFIX}/usr/sbin^" \
		${S}/ibacm/ibacm.service.in > ${T}/ibacm.service

	systemd_dounit ${S}/ibacm/ibacm.socket
	systemd_dounit ${T}/ibacm.service

	dodoc ${S}/Documentation/ibacm.md

	doman ${S}/ibacm/man/*.{1,7}

	sed -e "s^@CMAKE_INSTALL_FULL_LOCALSTATEDIR@^${EPREFIX}/var^" \
		${S}/ibacm/man/ibacm_prov.7.in > ${T}/ibacm_prov.7
	doman ${T}/ibacm_prov.7
}
