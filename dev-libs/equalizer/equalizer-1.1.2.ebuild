EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="Equalizer is the standard middleware to create and deploy parallel OpenGL-based applications"
HOMEPAGE="http://www.equalizergraphics.com"

EGIT_REPO_URI="git://github.com/Eyescale/Equalizer"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib hwsd glstats opencv osg +glew qt5"

RDEPEND="
    >=dev-libs/vmmlib-1.8
    >=dev-libs/lunchbox-1.10
    >=dev-libs/collage-1.1
    virtual/opengl
    >=dev-libs/boost-1.41.0
    >=dev-libs/pression-1.0
    hwsd? ( >=dev-libs/hwsd-1.1 )
    glstats? ( >=dev-libs/glstats-0.3 )
    opencv? ( >=media-libs/opencv-2.0 )
    osg? ( >=dev-games/openscenegraph-3.0 )
    glew? ( media-libs/glew )
    qt5? ( 
        dev-qt/qtcore:5
        dev-qt/qtopengl:5
        dev-qt/qtwidgets:5
    )

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
