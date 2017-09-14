EAPI=5
inherit cmake-utils

DESCRIPTION="Your toolbox, since the free lunch is over: a C++ library for multi-threaded programming"
HOMEPAGE="https://github.com/Eyescale/Lunchbox"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="git://github.com/Eyescale/Lunchbox.git"
    EGIT_BRANCH="master"
else
    #SRC_URI="https://github.com/Eyescale/Lunchbox/archive/${PV}.tar.gz -> ${P}.tar.gz"
    #S=${WORKDIR}/Lunchbox-${PV}
	EGIT_REPO_URI="git://github.com/Eyescale/Lunchbox.git"
	EGIT_COMMIT="${PV}"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

RDEPEND="
    >=dev-libs/boost-1.41.0
    >=dev-libs/servus-1.0
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
