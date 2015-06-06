EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="Equalizer is the standard middleware to create and deploy parallel OpenGL-based applications"
HOMEPAGE="http://www.equalizergraphics.com"

EGIT_REPO_URI="git://github.com/Eyescale/Equalizer"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

RDEPEND="
    >=dev-libs/vmmlib-1.8
    >=dev-libs/lunchbox-1.10
    >=dev-libs/collage-1.1
    virtual/opengl
    >=dev-libs/boost-1.41.0
    >=dev-libs/pression-1.0
    >=dev-libs/hwsd-1.1
    >=dev-libs/glstats-0.3
"
DEPEND="${RDEPEND}
    sys-devel/llvm
"

src_configure() {
    mycmakeargs=(
       $(cmake-utils_use_enable cxx11-stdlib CXX11_STDLIB)
    )

    cmake-utils_src_configure
}
