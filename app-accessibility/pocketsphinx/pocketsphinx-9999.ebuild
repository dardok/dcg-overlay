# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_OPTIONAL=1
inherit eutils distutils-r1

DESCRIPTION="Large open source vocabulary, speaker-independent continuous speech recognition engine"
HOMEPAGE="https://sourceforge.net/projects/cmusphinx/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cmusphinx/pocketsphinx.git"
	EGIT_BRANCH="master"
else
	SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="python static-libs"

RDEPEND="app-accessibility/sphinxbase
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch_user

	elibtoolize
	eaclocal
	eautoreconf
}

run_distutils() {
	if use python; then
		pushd python > /dev/null || die
		distutils-r1_"${@}"
		popd > /dev/null || die
	fi
}

src_configure() {
	econf \
		--without-python \
		$(use_enable static-libs static)
}

src_compile() {
	default
	run_distutils ${FUNCNAME}
}

src_install() {
	default
	run_distutils ${FUNCNAME}
	prune_libtool_files
}
