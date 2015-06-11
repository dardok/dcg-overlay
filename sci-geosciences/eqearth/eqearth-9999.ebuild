EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="osgEarth/Equalizer integration WIP"
HOMEPAGE="http://github.com/dardok/eqEarth/"

EGIT_REPO_URI="git://github.com/dardok/eqEarth.git"
EGIT_BRANCH="master"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	sci-geosciences/osgearth
    dev-libs/equalizer"
DEPEND="${RDEPEND}"

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
