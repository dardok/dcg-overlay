EAPI=6

OFED_VER="4.17"
OFED_RC="1"
OFED_RC_VER="1"
OFED_SUFFIX="rc1.1.g78b04f2"

IUSE_OFED_DRIVERS="
	ofed_drivers_bnxt_re
	ofed_drivers_cxgb3
	ofed_drivers_cxgb4
	ofed_drivers_hfi1
	ofed_drivers_hns
	ofed_drivers_i40iw
	ofed_drivers_ibscif
	ofed_drivers_ipath
	ofed_drivers_mlx4
	ofed_drivers_mlx5
	ofed_drivers_mthca
	ofed_drivers_nes
	ofed_drivers_ocrdma
	ofed_drivers_qedr
	ofed_drivers_rxe
	ofed_drivers_vmw_pvrdma
	"

inherit openib

DESCRIPTION="OFED meta package"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="dapl +diags ibacm ibpd mstflint opensm perftest qperf rds srp ${IUSE_OFED_DRIVERS}"

RDEPEND="
		sys-fabric/rdma-core:${SLOT}
		sys-fabric/libibumad:${SLOT}
		sys-fabric/libibverbs:${SLOT}
		sys-fabric/librdmacm:${SLOT}
		dapl? ( sys-fabric/dapl:${SLOT} )
		diags? ( sys-fabric/infiniband-diags:${SLOT} )
		ibacm? ( sys-fabric/ibacm:${SLOT} )
		ibpd? ( sys-fabric/ibpd:${SLOT} )
		mstflint? ( sys-fabric/mstflint:${SLOT} )
		opensm? ( sys-fabric/opensm:${SLOT} )
		perftest? ( sys-fabric/perftest:${SLOT} )
		qperf? ( sys-fabric/qperf:${SLOT} )
		rds? ( sys-fabric/rds-tools:${SLOT} )
		srp? ( sys-fabric/srptools:${SLOT} )
		ofed_drivers_bnxt_re? ( sys-fabric/libbnxt-re:${SLOT} )
		ofed_drivers_cxgb3? ( sys-fabric/libcxgb3:${SLOT} )
		ofed_drivers_cxgb4? ( sys-fabric/libcxgb4:${SLOT} )
		ofed_drivers_hfi1? ( sys-fabric/libhfi1verbs:${SLOT} )
		ofed_drivers_hns? ( sys-fabric/libhns:${SLOT} )
		ofed_drivers_i40iw? ( sys-fabric/libi40iw:${SLOT} )
		ofed_drivers_ibscif? ( sys-fabric/libibscif:${SLOT} )
		ofed_drivers_ipath? ( sys-fabric/libipathverbs:${SLOT} )
		ofed_drivers_mlx4? ( sys-fabric/libmlx4:${SLOT} )
		ofed_drivers_mlx5? ( sys-fabric/libmlx5:${SLOT} )
		ofed_drivers_mthca? ( sys-fabric/libmthca:${SLOT} )
		ofed_drivers_nes? ( sys-fabric/libnes:${SLOT} )
		ofed_drivers_ocrdma? ( sys-fabric/libocrdma:${SLOT} )
		ofed_drivers_qedr? ( sys-fabric/libqedr:${SLOT} )
		ofed_drivers_rxe? ( sys-fabric/librxe:${SLOT} )
		ofed_drivers_vmw_pvrdma? ( sys-fabric/libvmw-pvrdma:${SLOT} )
		"
DEPEND="${RDEPEND}"

block_other_ofed_versions

src_prepare() { :; }
src_configure() { :; }
src_compile() { :; }
src_install() { :; }
