EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="Cross-platform C++ library for building heterogenous, distributed applications"
HOMEPAGE="http://libcollage.net/"

EGIT_REPO_URI="git://github.com/Eyescale/Collage.git"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib infiniband"

RDEPEND="
    >=dev-libs/boost-1.41.0
    >=dev-libs/lunchbox-1.10
    >=dev-libs/pression-1.0
    infiniband? ( sys-infiniband/librdmacm )
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
