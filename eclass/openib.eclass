# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/openib.eclass,v 1.11 2014/04/16 10:09:29 alexxy Exp $

# @ECLASS: openib.eclass
# @AUTHOR:
# Original Author: Alexey Shvetsov <alexxy@gentoo.org>
# @BLURB: Simplify working with OFED packages

inherit eutils rpm versionator eapi7-ver

EXPORT_FUNCTIONS src_unpack

HOMEPAGE="http://www.openfabrics.org/"
LICENSE="|| ( GPL-2 BSD-2 )"

# @ECLASS-VARIABLE: OFED_VER
# @DESCRIPTION:
# Defines OFED version

# @ECLASS-VARIABLE: OFED_RC
# @DESCRIPTION:
# Sets if this version is RC

# @ECLASS-VARIABLE: OFED_RC_VER
# @DESCRIPTION:
# Sets RC version

# @ECLASS-VARIABLE: OFED_SUFFIX
# @DESCRIPTION:
# Defines OFED package suffix eg -1.g78b04f2

# @ECLASS-VARIABLE: RDMA_CORE_VER
# @DESCRIPTION:
# Defines rdma-core package version eg 17.2-1

SLOT="${OFED_VER}"

# @ECLASS-VARIABLE: OFED_VERSIONS
# @DESCRIPTION:
# Defines array of ofed version supported by eclass

OFED_VERSIONS=(
	"4.17"
	)

# @FUNCTION: block_other_ofed_versions
# @DESCRIPTION:
# function that creates blockers list for ofed
block_other_ofed_versions() {
	local slot
	RDEPEND="${RDEPEND} !sys-fabric/${PN}:0"
	for slot in ${OFED_VERSIONS[@]}; do
		if [[ ${slot} != ${SLOT} ]]; then
			RDEPEND+=" !sys-fabric/${PN}:${slot}"
		fi
	done
}

OFED_BASE_VER=$(get_version_component_range 1-3 ${OFED_VER})

if [ -z $OFED_RC ] ; then
	SRC_URI="https://www.openfabrics.org/downloads/OFED/ofed-${OFED_BASE_VER}/OFED-${OFED_VER}.tgz"
else
	SRC_URI="https://www.openfabrics.org/downloads/OFED/ofed-${OFED_BASE_VER}/OFED-${OFED_VER}-rc${OFED_RC_VER}.tgz"
fi

case ${PN} in
	ofed)
		MY_PN="compat-rdma"
		S="${WORKDIR}/${MY_PN}-${OFED_BASE_VER}"
		;;
	ibacm|libibumad|libibverbs|librdmacm|srptools|libbnxt-re|libcxgb3|libcxgb4|libhfi1|libhns|libi40iw|libipathverbs|libmlx4|libmlx5|libmthca|libnes|libocrdma|libqedr|librxe|libvmw-pvrdma)
		MY_PN="rdma-core"
		RDMA_CORE_PKG_VER=$(get_version_component_range 1-2 ${RDMA_CORE_VER})
		S="${WORKDIR}/${MY_PN}-${RDMA_CORE_PKG_VER}"
		;;
	*)
		MY_PN="${PN}"
		S="${WORKDIR}/${MY_PN}-${PV}"
		;;
esac

case ${MY_PN} in
	compat-rdma)
		EXT="tgz"
		;;
	libfabric|libibscif)
		EXT="tar.bz2"
		;;
	*)
		EXT="tar.gz"
		;;
esac

# @FUNCTION: openib_src_unpack
# @DESCRIPTION:
# This function will unpack OFED packages
openib_src_unpack() {
	unpack ${A}
	if [ -z ${OFED_RC} ]; then
		case ${MY_PN} in
			compat-rdma)
				rpm_unpack "./OFED-${OFED_VER}/SRPMS/${MY_PN}-${OFED_VER}-${OFED_SUFFIX}.src.rpm"
				;;
			rdma-core)
				rpm_unpack "./OFED-${OFED_VER}/SRPMS/RH/${MY_PN}-${RDMA_CORE_VER}.src.rpm"
				;;
			*)
				rpm_unpack "./OFED-${OFED_VER}/SRPMS/${MY_PN}-${PV}-${OFED_SUFFIX}.src.rpm"
				;;
		esac
	else
		case ${MY_PN} in
			compat-rdma)
				rpm_unpack "./OFED-${OFED_VER}-rc${OFED_RC_VER}/SRPMS/${MY_PN}-${OFED_VER}-${OFED_SUFFIX}.src.rpm"
				;;
			rdma-core)
				rpm_unpack "./OFED-${OFED_VER}-rc${OFED_RC_VER}/SRPMS/RH/${MY_PN}-${RDMA_CORE_VER}.src.rpm"
				;;
			*)
				rpm_unpack "./OFED-${OFED_VER}-rc${OFED_RC_VER}/SRPMS/${MY_PN}-${PV}-${OFED_SUFFIX}.src.rpm"
				;;
		esac
	fi
	case ${MY_PN} in
		compat-rdma)
			unpack ./${MY_PN}-${OFED_VER}.${EXT}
			;;
		rdma-core)
			RDMA_CORE_PKG_VER=$(get_version_component_range 1-2 ${RDMA_CORE_VER})
			unpack ./${MY_PN}-${RDMA_CORE_PKG_VER}.tgz
			;;
		ibutils|perftest)
			unpack ./${MY_PN}-${PV}-${OFED_SUFFIX}.${EXT}
			;;
		*)
			PKG_VER=$(get_version_component_range 1-3 ${PV})
			unpack ./${MY_PN}-${PKG_VER}.${EXT}
			;;
	esac
}
