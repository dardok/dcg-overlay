# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osgearth/osgearth-2.6.ebuild,v 1.1 2014/10/10 20:18:46 hasufell Exp $

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Dynamic map generation toolkit for OpenSceneGraph"
HOMEPAGE="http://osgearth.org/"

EGIT_REPO_URI="git://github.com/gwaldron/osgearth.git"
EGIT_BRANCH="master"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc protobuf qt5"

RDEPEND="
	dev-db/sqlite:3
	>=dev-games/openscenegraph-3.2.1[curl]
    dev-libs/leveldb
	dev-libs/tinyxml
	net-misc/curl
	sci-libs/gdal
	sci-libs/geos
	sys-libs/zlib[minizip]
	virtual/opengl
	x11-libs/libX11
    protobuf? ( dev-libs/protobuf )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtopengl:5
		dev-qt/qtwidgets:5
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( dev-python/sphinx )"

#S=${WORKDIR}/${PN}-${P}

#PATCHES=( "${FILESDIR}"/osgearth-2.6-cmake-options.patch )

src_configure() {
	# V8 disabled due to
	# https://github.com/gwaldron/osgearth/issues/333
	local mycmakeargs=(
		-DWITH_EXTERNAL_TINYXML=ON
		$(cmake-utils_use qt5 OSGEARTH_USE_QT)
		-DOSGEARTH_USE_V8=OFF
		-DOSGEARTH_USE_JAVASCRIPTCORE=OFF
		-DOSGEARTH_USE_LIBNOISE=OFF
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	if use doc ; then
		emake -C "${S}"/docs man html info
	fi
}

src_install() {
	cmake-utils_src_install

	if use doc ; then
		dohtml -r "${S}"/docs/build/html/*
		doman "${S}"/docs/build/man/*
		doinfo "${S}"/docs/build/texinfo/*.info*
	fi
}
