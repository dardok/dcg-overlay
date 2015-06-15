EAPI=5

inherit git-r3

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
    default
}

src_compile() {
    make -j16 || die
}

src_install() {
    mkdir -p ${D}/usr/bin || die
    cp ${S}/eqEarth ${D}/usr/bin/eqEarth || die
}
