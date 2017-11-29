# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.10"
WANT_LIBTOOL="latest"

if [[ $PV = *9999* ]]; then
	KEYWORDS=""
	EGIT_BRANCH="master"
else
	KEYWORDS="~amd64"
	EGIT_TAG="${PV}"
fi

inherit git-r3 autotools linux-info linux-mod toolchain-funcs udev flag-o-matic

DESCRIPTION="Lustre is a parallel distributed file system"
HOMEPAGE="http://wiki.whamcloud.com/"
EGIT_REPO_URI="git://git.hpdd.intel.com/fs/lustre-release.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="+client +utils server liblustre readline tests tcpd +checksum lru-resize snmp gss"

RDEPEND="
	virtual/awk
	readline? ( sys-libs/readline:0 )
	tcpd? ( sys-apps/tcp-wrappers )
	server? (
		>=sys-kernel/spl-0.6.1
		>=sys-fs/zfs-kmod-0.6.1
		sys-fs/zfs
	)
    snmp? ( net-analyzer/net-snmp )
	"
DEPEND="${RDEPEND}
    dev-python/docutils
	server? ( virtual/linux-sources )
	client? ( virtual/linux-sources )"

pkg_setup() {
    linux-info_pkg_setup
	filter-mfpmath sse
	filter-mfpmath i386
	filter-flags -msse* -mavx* -mmmx -m3dnow
    if use client or use server; then
	    linux-mod_pkg_setup
	    ARCH="$(tc-arch-kernel)"
	    ABI="${KERNEL_ABI}"
    fi
}

src_prepare() {
    epatch_user

	# replace upstream autogen.sh by our src_prepare()
	local DIRS="libcfs lnet lustre snmp"
	local ACLOCAL_FLAGS
	for dir in $DIRS ; do
		ACLOCAL_FLAGS="$ACLOCAL_FLAGS -I $dir/autoconf"
	done
	_elibtoolize -q
	eaclocal -I config $ACLOCAL_FLAGS
	eautoheader
	eautomake
	eautoconf
}

use_disable() {
	use $1 || echo "--disable-$1"
}

src_configure() {
    set_arch_to_kernel

	local myconf
	if use server; then
		SPL_PATH=$(basename $(echo "${EROOT}usr/src/spl-"*)) \
			myconf="${myconf} --with-spl=${EROOT}usr/src/${SPL_PATH} \
							--with-spl-obj=${EROOT}usr/src/${SPL_PATH}/${KV_FULL}"
		ZFS_PATH=$(basename $(echo "${EROOT}usr/src/zfs-"*)) \
			myconf="${myconf} --with-zfs=${EROOT}usr/src/${ZFS_PATH} \
							--with-zfs-obj=${EROOT}usr/src/${ZFS_PATH}/${KV_FULL}"
	fi
    if ! use server && ! use client; then
        myconf="${myconf} --disable-modules"
    fi
	econf \
		${myconf} \
		--disable-ldiskfs \
		--with-linux="${KV_DIR}" \
		--with-linux-obj="${KV_OUT_DIR}" \
		$(use_enable client) \
		$(use_enable utils) \
		$(use_enable server) \
		$(use_enable liblustre) \
		$(use_enable readline) \
		$(use_enable tcpd libwrap) \
		$(use_enable tests) \
		$(use_disable checksum) \
		$(use_enable lru-resize) \
		$(use_enable snmp) \
		$(use_enable gss)

	touch undef.h
}

src_compile() {
	default
}

src_install() {
	default
}
