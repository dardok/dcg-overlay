EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="Compression and data transfer plugins"
HOMEPAGE="https://github.com/Eyescale/Pression"

EGIT_REPO_URI="git://github.com/Eyescale/Pression.git"
EGIT_BRANCH="master"

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
