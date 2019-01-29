# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC=""
OFED_RC_VER=""
RDMA_CORE_VER="17.2-1"

inherit openib cmake-utils systemd

DESCRIPTION="srptools"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fabric/libibverbs:${SLOT}"
RDEPEND="virtual/perl-Getopt-Long
		${DEPEND}"

block_other_ofed_versions

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile srp_daemon
}

src_install() {
	insinto /etc/rdma/modules
	newins ${S}/srp_daemon/modules-srp_daemon.conf srp_daemon.conf

	insinto /lib/udev/rules.d
	newins ${S}/srp_daemon/srp_daemon.rules 60-srp_daemon.rules

	insinto /etc
	doins ${S}/srp_daemon/srp_daemon.conf

	dosbin ${BUILD_DIR}/bin/srp_daemon
	dosym srp_daemon ${EPREFIX}/usr/sbin/ibsrpdm
	dosym srp_daemon ${EPREFIX}/usr/sbin/run_srp_daemon

	exeinto /usr/libexec
	doexe ${S}/srp_daemon/start_on_all_ports

	sed -e "s^@CMAKE_INSTALL_FULL_LIBEXECDIR@^${EPREFIX}/usr/libexec^" \
		${S}/srp_daemon/srp_daemon.service.in > ${T}/srp_daemon.service
	sed -e "s^@CMAKE_INSTALL_FULL_SBINDIR@^${EPREFIX}/usr/sbin^" \
		${S}/srp_daemon/srp_daemon_port@.service.in > ${T}/srp_daemon_port@.service

	systemd_dounit ${T}/srp_daemon.service
	systemd_dounit ${T}/srp_daemon_port@.service
}
