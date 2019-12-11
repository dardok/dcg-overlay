EAPI=5
inherit cmake-utils

DESCRIPTION="C++ library for building applications to stream pixels to DisplayCluster"
HOMEPAGE="https://github.com/BlueBrain/Deflect"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/BlueBrain/Deflect.git"
	EGIT_BRANCH="master"
else
	#SRC_URI="https://github.com/BlueBrain/Deflect/archive/${PV}.tar.gz -> ${P}.tar.gz"
	#S=${WORKDIR}/Deflect-${PV}
	inherit git-r3
	EGIT_REPO_URI="https://github.com/BlueBrain/Deflect"
	EGIT_COMMIT="${PV}"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +cxx11-stdlib +glut"

RDEPEND="
	>=dev-libs/boost-1.54.0
	( =media-libs/libjpeg-turbo-1* )
	glut? ( media-libs/freeglut )
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}
	sys-devel/llvm
"

PATCHES=(
	"${FILESDIR}/jpegturbo-version.patch"
)

src_prepare() {
	epatch "${PATCHES[@]}"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable cxx11-stdlib CXX11_STDLIB)
	)

	cmake-utils_src_configure
}
