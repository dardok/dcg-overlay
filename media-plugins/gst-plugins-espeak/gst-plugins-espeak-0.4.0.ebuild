# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools

DESCRIPTION="ESpeak GStreamer plugins"
HOMEPAGE="http://download.sugarlabs.org/sources/honey/gst-plugins-espeak/"

SRC_URI="http://download.sugarlabs.org/sources/honey/gst-plugins-espeak/gst-plugins-espeak-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"

RDEPEND="
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	app-accessibility/espeak"
DEPEND="${RDEPEND}"
