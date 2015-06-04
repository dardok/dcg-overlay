EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="C++ network utility library"
HOMEPAGE="https://github.com/HBPVIS/Servus"

EGIT_REPO_URI="git://github.com/HBPVIS/Servus.git"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

RDEPEND="
    >=dev-libs/boost-1.41.0
    net-dns/avahi
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
