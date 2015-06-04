EAPI=5
inherit git-r3 cmake-utils

DESCRIPTION="Local and remote ZeroConf service discovery for hardware resources"
HOMEPAGE="https://github.com/Eyescale/hwsd"

EGIT_REPO_URI="git://github.com/Eyescale/hwsd.git"
EGIT_BRANCH="master"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

RDEPEND="
    >=dev-libs/lunchbox-1.10
    >=dev-libs/boost-1.41.0
    >=dev-libs/servus-1.0
"
DEPEND="${RDEPEND}
    sys-devel/llvm
"

src_prepare() {
    # violates sandbox
    sed -i -e '/^install_symlinkd' ${S}/apps/hw_sd/CMakeLists.txt
    sed -i -e '/^install_symlinkd' ${S}/apps/hw_sd_list/CMakeLists.txt
}

src_configure() {
    mycmakeargs=(
        $(cmake-utils_use_enable cxx11-stdlib CXX11_STDLIB)
    )

    cmake-utils_src_configure
}

src_install() {
    cmake-utils_src_install

    ln -sf hw_sd ${I}/bin/gpu_sd
    ln -sf hw_sd ${I}/bin/net_sd
    ln -sf hw_sd_list ${I}/bin/gpu_sd_list
    ln -sf hw_sd_list ${I}/bin/net_sd_list
}
