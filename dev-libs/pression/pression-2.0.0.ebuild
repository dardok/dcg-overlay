EAPI=5
inherit cmake-utils

DESCRIPTION="Compression and data transfer plugins"
HOMEPAGE="https://github.com/Eyescale/Pression"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/Eyescale/Pression.git"
	EGIT_BRANCH="master"
else
	inherit git-r3
	#SRC_URI="https://github.com/Eyescale/Pression/archive/${PV}.tar.gz -> ${P}.tar.gz"
	#S=${WORKDIR}/Pression-${PV}
	EGIT_REPO_URI="git://github.com/Eyescale/Pression.git"
	EGIT_COMMIT="${PV}"
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

src_prepare() {
	git -C pression/compressor clone https://github.com/facebook/zstd.git
	git -C pression/compressor/zstd reset --hard 83543a7b26f8130ede672628d86c063d9a6c3f38
}

src_configure() {
	mycmakeargs=(
		-DCMAKE_C_FLAGS="${CFLAGS} -Wno-expansion-to-defined -Wno-implicit-fallthrough -Wno-unused-function"
		$(cmake-utils_use_enable cxx11-stdlib CXX11_STDLIB)
	)

	cmake-utils_src_configure
}
