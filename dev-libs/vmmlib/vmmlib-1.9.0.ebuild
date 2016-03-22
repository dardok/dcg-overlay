EAPI=5
inherit cmake-utils

DESCRIPTION="A templatized C++ vector and matrix math library"
HOMEPAGE="http://vmml.github.com/vmmlib/"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="git://github.com/Eyescale/vmmlib.git"
    EGIT_BRANCH="master"
else
    SRC_URI="https://github.com/Eyescale/vmmlib/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug"

RDEPEND=""
DEPEND="${RDEPEND}"
