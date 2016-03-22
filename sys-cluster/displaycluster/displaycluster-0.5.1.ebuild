EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="A collaborative software for driving large display walls"
HOMEPAGE="https://github.com/BlueBrain/DisplayCluster"

EGIT_REPO_URI="git://github.com/BlueBrain/DisplayCluster.git"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

# NOTE: replace qtquick1 with qtdeclarative when possible
RDEPEND="
    >=dev-libs/boost-1.41.0
    >=dev-libs/deflect-0.4
    dev-libs/fcgi
    media-video/ffmpeg
    sys-cluster/openmpi
    virtual/opengl
    dev-qt/qtconcurrent:5
    dev-qt/qtcore:5
    dev-qt/qtdeclarative:5
    dev-qt/qtnetwork:5
    dev-qt/qtopengl:5
    dev-qt/qtquick1:5
    dev-qt/qtsvg:5
    dev-qt/qtwebkit:5
    dev-qt/qtwidgets:5
    dev-qt/qtxml:5
    dev-qt/qtxmlpatterns:5
"
DEPEND="${RDEPEND}
    sys-devel/llvm
"

src_prepare() {
    # test linkage is broken (/usr/lib64/libX11.so.6: error adding symbols: DSO missing from command line)
    sed -i -e '/add_subdirectory(tests)/d' ${S}/CMakeLists.txt
}

src_configure() {
    mycmakeargs=(
		-DSUBPROJECT_TUIO=OFF
		$(cmake-utils_use_enable cxx11-stdlib CXX11_STDLIB)
    )

	cmake-utils_src_configure
}
