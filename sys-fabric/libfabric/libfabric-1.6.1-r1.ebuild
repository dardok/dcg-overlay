EAPI=6

OFED_VER="4.17"
OFED_RC="1"
OFED_RC_VER="1"
OFED_SUFFIX="1"

inherit openib

DESCRIPTION="OFI"

KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sys-fabric/librdmacm:${SLOT}
		sys-fabric/libibverbs:${SLOT}
		sys-fabric/libibumad:${SLOT}
		"
RDEPEND="${DEPEND}"

block_other_ofed_versions
