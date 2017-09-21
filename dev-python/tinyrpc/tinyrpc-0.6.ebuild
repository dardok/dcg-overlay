# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="A small and modular way of handling web-related RPC"
HOMEPAGE="https://pypi.python.org/pypi/tinyrpc https://github.com/mbr/tinyrpc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="doc"

# Req'd for test phase
DISTUTILS_IN_SOURCE_BUILD=1
