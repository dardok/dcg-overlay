# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

OFED_VER="4.17"
OFED_RC="1"
OFED_RC_VER="1"
OFED_SUFFIX="3.3.21"

inherit autotools eutils openib systemd

DESCRIPTION="OpenSM - InfiniBand Subnet Manager and Administration for OpenIB"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="+sldd static-libs systemd"

DEPEND="sys-fabric/libibumad:${SLOT}"
RDEPEND="$DEPEND
		sldd? (
			net-misc/iputils
			net-misc/openssh
		)"

block_other_ofed_versions

src_prepare() {
	epatch "${FILESDIR}/${P}-norpm.patch"
	epatch "${FILESDIR}/${P}-sldd.patch"

	eautoreconf

	default
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--enable-default-event-plugin \
		--with-osmv="openib"
}

src_install() {
	default

	newconfd "${FILESDIR}/opensm.conf.d" opensm
	newinitd "${FILESDIR}/opensm.init.d" opensm
	insinto /etc/logrotate.d
	newins "${S}/scripts/opensm.logrotate" opensm

	# we dont nee this int script
	rm "${ED}/etc/init.d/opensmd" || die "Dropping of upstream initscript failed"

	if use sldd; then
		dosbin scripts/sldd.sh
		newconfd "${FILESDIR}/sldd.conf.d" sldd
		newinitd "${FILESDIR}/sldd.init.d" sldd
	fi

	if use systemd; then
		insinto "$(systemd_get_systemunitdir)"
		doins ${FILESDIR}/opensm.service

		insinto /usr/libexec
		doins ${FILESDIR}/opensm-launch
	fi
}

pkg_postinst() {
	einfo "To automatically configure the infiniband subnet manager on boot,"
	einfo "edit /etc/opensm.conf and add opensm to your start-up scripts:"
	einfo "\`rc-update add opensm default\`"
}
