# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils systemd

DESCRIPTION="RDMA core"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

block_other_ofed_versions

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile rdma-ndd
}

src_install() {
	insinto /etc/udev/rules.d
	newins ${S}/kernel-boot/persistent-ipoib.rules 70-persistent-ipoib.rules

	insinto /lib/udev/rules.d
	newins ${S}/kernel-boot/rdma-ulp-modules.rules 90-rdma-ulp-modules.rules
	newins ${S}/kernel-boot/rdma-description.rules 75-rdma-description.rules
	newins ${S}/kernel-boot/rdma-hw-modules.rules 90-rdma-hw-modules.rules
	newins ${S}/kernel-boot/rdma-umad.rules 90-rdma-umad.rules
	newins ${S}/redhat/rdma.udev-rules 98-rdma.rules

	newins ${S}/rdma-ndd/rdma-ndd.rules 60-rdma-ndd.rules

	dosbin ${BUILD_DIR}/bin/rdma-ndd

	insinto /etc/rdma
	doins ${S}/redhat/rdma.conf
	newins ${S}/redhat/rdma.sriov-vfs sriov-vfs

	insinto /etc/rdma/modules
	doins ${S}/kernel-boot/modules/rdma.conf
	doins ${S}/kernel-boot/modules/infiniband.conf
	doins ${S}/kernel-boot/modules/iwarp.conf
	doins ${S}/kernel-boot/modules/opa.conf
	doins ${S}/kernel-boot/modules/roce.conf

	exeinto /usr/libexec
	newexe ${S}/redhat/rdma.kernel-init rdma-init-kernel
	newexe ${S}/redhat/rdma.sriov-init rdma-set-sriov-vf

	sed -e "s^@CMAKE_INSTALL_FULL_SYSCONFDIR@^${EPREFIX}/etc^" \
		-e "s^@CMAKE_INSTALL_FULL_DOCDIR@^${EPREFIX}/usr/share/doc/rdma-core-${PV}^" \
		-e "s^@CMAKE_INSTALL_SYSTEMD_BINDIR@^$(systemd_get_utildir)^" \
		${S}/kernel-boot/rdma-load-modules@.service.in > ${T}/rdma-load-modules@.service
	sed -e "s^@CMAKE_INSTALL_FULL_DOCDIR@^${EPREFIX}/usr/share/doc/rdma-core-${PV}^" \
		${S}/kernel-boot/rdma-hw.target.in > ${T}/rdma-hw.target
	sed -e "s^@CMAKE_INSTALL_FULL_SBINDIR@^${EPREFIX}/usr/sbin^" \
		${S}/rdma-ndd/rdma-ndd.service.in > ${T}/rdma-ndd.service

	systemd_dounit ${T}/rdma-load-modules@.service
	systemd_dounit ${T}/rdma-hw.target
	systemd_dounit ${T}/rdma-ndd.service

	systemd_dounit ${S}/redhat/rdma.service
}
