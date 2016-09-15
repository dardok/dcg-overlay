EAPI=5
inherit cmake-utils

DESCRIPTION="C++ network utility library"
HOMEPAGE="https://github.com/HBPVIS/Servus"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="git://github.com/HBPVIS/Servus.git"
    EGIT_BRANCH="master"
else
	SRC_URI="https://github.com/HBPVIS/Servus/archive/${PV}.tar.gz -> ${P}.tar.gz"
    S=${WORKDIR}/Servus-${PV}
fi


LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

RDEPEND="
    >=dev-libs/boost-1.54.0
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
