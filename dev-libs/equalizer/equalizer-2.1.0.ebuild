EAPI=5
inherit cmake-utils

DESCRIPTION="Equalizer is the standard middleware to create and deploy parallel OpenGL-based applications"
HOMEPAGE="http://www.equalizergraphics.com"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="git://github.com/Eyescale/Equalizer"
    EGIT_BRANCH="master"
else
    #SRC_URI="https://github.com/Eyescale/Equalizer/archive/${PV}.tar.gz -> ${P}.tar.gz"
    #S=${WORKDIR}/Equalizer-${PV}
    inherit git-r3
    EGIT_REPO_URI="git://github.com/Eyescale/Equalizer"
    EGIT_COMMIT="${PV}"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib hwsd glstats osg +glew qt5"

RDEPEND="
    >=dev-libs/vmmlib-1.12
    >=dev-libs/lunchbox-1.10
    >=dev-libs/collage-1.1
    >=dev-libs/deflect-0.4
    virtual/opengl
    >=dev-libs/boost-1.41.0
    >=dev-libs/pression-1.0
    hwsd? ( >=dev-libs/hwsd-1.1 )
    glstats? ( >=dev-libs/glstats-0.3 )
    media-libs/opencv:0/3.4.1
    osg? ( >=dev-games/openscenegraph-3.0 )
    glew? ( media-libs/glew )
    qt5? ( 
        dev-qt/qtcore:5
        dev-qt/qtconcurrent:5
        dev-qt/qtnetwork:5
        dev-qt/qtopengl:5
        dev-qt/qtwidgets:5
    )

"
DEPEND="${RDEPEND}
    sys-devel/llvm
"

PATCHES=(
    "${FILESDIR}/${PV}-sceneview.patch"
    "${FILESDIR}/${PV}-cvtracker.patch"
    "${FILESDIR}/${PV}-deflect.patch"
    "${FILESDIR}/cuda-9.0.patch"
)

src_prepare() {
    epatch "${PATCHES[@]}"
}

src_configure() {
    mycmakeargs=(
       $(cmake-utils_use_enable cxx11-stdlib CXX11_STDLIB)
    )

    cmake-utils_src_configure
}
