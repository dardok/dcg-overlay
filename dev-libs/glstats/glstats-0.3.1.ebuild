EAPI=5
inherit cmake-utils

DESCRIPTION="Generic OpenGL overlay statistics renderer"
HOMEPAGE="https://github.com/Eyescale/GLStats"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="git://github.com/Eyescale/GLStats.git"
    EGIT_BRANCH="master"
else
    SRC_URI="https://github.com/Eyescale/GLStats/archive/0.3.1.tar.gz"
    S=${WORKDIR}/GLStats-${PV}
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

RDEPEND="
    >=dev-libs/lunchbox-1.10
    virtual/opengl
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
