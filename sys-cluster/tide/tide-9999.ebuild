EAPI=5
inherit cmake-utils

DESCRIPTION="A collaborative software for driving large display walls"
HOMEPAGE="https://github.com/BlueBrain/Tide"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="git://github.com/BlueBrain/Tide.git"
    EGIT_BRANCH="master"
else
    SRC_URI="https://github.com/BlueBrain/Tide/archive/${PV}.tar.gz -> ${P}.tar.gz"
    S=${WORKDIR}/Tide-${PV}
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug +cxx11-stdlib"

RDEPEND="
    >=dev-libs/boost-1.54.0
    =dev-libs/deflect-9999
    media-video/ffmpeg
    sys-cluster/openmpi
    virtual/opengl
    dev-qt/qtconcurrent:5
    dev-qt/qtcore:5
    dev-qt/qtdeclarative:5
    dev-qt/qtnetwork:5
    dev-qt/qtopengl:5
    dev-qt/qtquickcontrols:5
    dev-qt/qtsvg:5
    dev-qt/qtwebkit:5
    dev-qt/qtwidgets:5
    dev-qt/qtxml:5
    dev-qt/qtxmlpatterns:5
    dev-qt/qtgraphicaleffects:5
    dev-qt/qtx11extras:5
"
DEPEND="${RDEPEND}
    sys-devel/llvm
"

#PATCHES=(
#    "${FILESDIR}/local.patch"
#)
#
#src_prepare() {
#	epatch "${PATCHES[@]}"
#}

src_configure() {
    mycmakeargs=(
		-DCLONE_SUBPROJECTS=ON
		$(cmake-utils_use_enable cxx11-stdlib CXX11_STDLIB)
    )

	cmake-utils_src_configure
}
