EAPI="5"

OFED_VER="3.18"
OFED_RC="1"
OFED_RC_VER="3"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OFI"

KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-fabric/librdmacm:${SLOT}
	sys-fabric/libibverbs:${SLOT}
	sys-fabric/libibumad:${SLOT}
	"
RDEPEND="${DEPEND}"
block_other_ofed_versions