# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit flag-o-matic systemd
if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://svn.code.sf.net/p/smartmontools/code/trunk/smartmontools"
	ESVN_PROJECT="smartmontools"
	inherit subversion autotools
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~x64-macos"
fi

DESCRIPTION="Tools to monitor storage systems to provide advanced warning of disk degradation"
HOMEPAGE="https://www.smartmontools.org"

LICENSE="GPL-2"
SLOT="0"
IUSE="caps minimal selinux static update_drivedb"

DEPEND="
	caps? (
		static? ( sys-libs/libcap-ng[static-libs] )
		!static? ( sys-libs/libcap-ng )
	)
	selinux? (
		sys-libs/libselinux
	)"
RDEPEND="${DEPEND}
	!minimal? ( virtual/mailx )
	selinux? ( sec-policy/selinux-smartmon )
"

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		eautoreconf
	fi
}

src_configure() {
	use minimal && einfo "Skipping the monitoring daemon for minimal build."
	use static && append-ldflags -static
	# The build installs /etc/init.d/smartd, but we clobber it
	# in our src_install, so no need to manually delete it.
	myeconfargs=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
		--with-drivedbdir="${EPREFIX}/var/db/${PN}" #575292
		--with-initscriptdir="${EPREFIX}/etc/init.d"
		$(use_with caps libcap-ng)
		$(use_with selinux)
		$(systemd_with_unitdir)
		$(use_with update_drivedb update-smart-drivedb)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	local db_path="/var/db/${PN}"

	if use minimal ; then
		dosbin smartctl
		doman smartctl.8
	else
		default
		newinitd "${FILESDIR}"/smartd-r1.rc smartd
		newconfd "${FILESDIR}"/smartd.confd smartd

		keepdir "${db_path}"
		if use update_drivedb ; then
			# Move drivedb.h file out of PM's sight (bug #575292)
			mv "${ED}${db_path}/drivedb.h" "${T}" || die

			exeinto /etc/cron.monthly
			doexe "${FILESDIR}/${PN}-update-drivedb"
		fi
	fi
}

pkg_postinst() {
	if ! use minimal ; then
		local db_path="/var/db/${PN}"

		if [[ -f "${db_path}/drivedb.h" ]] ; then
			ewarn "WARNING! The existing copy of the drive database has been replaced with the version that"
			ewarn "was shipped with this release of ${PN}. You may want to update the"
			ewarn "database by: "

			if ! use update_drivedb ; then
				ewarn "re-merging ${PN} with USE='update_drivedb', then"
			fi
			ewarn "running the following command as root:"
			ewarn ""
			ewarn "/usr/sbin/update-smart-drivedb"
		fi

		if use update_drivedb ; then
			# Move drivedb.h to /var/db/${PN} (bug #575292)
			#mv "${T}"/drivedb.h "${db_path}" || die
			/usr/sbin/update-smart-drivedb
		fi
	fi
}
