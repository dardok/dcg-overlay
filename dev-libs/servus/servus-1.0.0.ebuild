# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="C++ network utility library"
HOMEPAGE="https://github.com/HBPVIS/Servus"

EGIT_REPO_URI="git://github.com/HBPVIS/Servus.git"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
        local mycmakeargs=(
                -DCMAKE_BUILD_TYPE=Release
        )

        cmake-utils_src_configure
}

src_compile() {
        cmake-utils_src_compile
}

src_install() {
        cmake-utils_src_install
}
