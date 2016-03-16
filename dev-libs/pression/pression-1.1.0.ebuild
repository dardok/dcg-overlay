EAPI=5
inherit cmake-utils

DESCRIPTION="Compression and data transfer plugins"
HOMEPAGE="https://github.com/Eyescale/Pression"

if [[ ${PV} = *9999* ]]; then
    EGIT_REPO_URI="git://github.com/Eyescale/Pression.git"
    EGIT_BRANCH="master"
else
    SRC_URI="https://github.com/Eyescale/Pression/archive/1.1.0.tar.gz -> ${P}.tar.gz"
    S=${WORKDIR}/Pression-${PV}
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

RDEPEND="
    >=dev-libs/boost-1.41.0
    >=dev-libs/lunchbox-1.10
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
