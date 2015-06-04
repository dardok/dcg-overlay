# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="C++ library for building applications to stream pixels to DisplayCluster"
HOMEPAGE="https://github.com/BlueBrain/Deflect"

EGIT_REPO_URI="git://github.com/BlueBrain/Deflect.git"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="
	dev-libs/servus
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"

src_configure() {
        cmake-utils_src_configure
}

src_compile() {
        cmake-utils_src_compile
}

src_install() {
        cmake-utils_src_install
}
