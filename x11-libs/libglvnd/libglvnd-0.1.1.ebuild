EAPI=5

inherit eutils autotools

DESCRIPTION="libglvnd is a vendor-neutral dispatch layer for arbitrating OpenGL API calls between multiple vendors."
HOMEPAGE="https://github.com/NVIDIA/libglvnd"
SRC_URI="https://github.com/NVIDIA/libglvnd/archive/v${PV}.tar.gz"

LICENSE="NVIDIA-r2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/libXext x11-libs/libX11 x11-proto/glproto"
RDEPEND="${DEPEND}"

src_prepare() {
    ./autogen.sh || die "autogen failed"
}
