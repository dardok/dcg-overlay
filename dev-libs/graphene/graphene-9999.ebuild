EAPI=5

DESCRIPTION="A thin layer of graphic data types"
HOMEPAGE="http://ebassi.github.com/graphene"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="git://ebassi.github.com/graphene.git"
    EGIT_BRANCH="master"
else
    SRC_URI="https://github.com/ebassi/graphene/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

src_prepare() {
    NOCONFIGURE=1 ./autogen.sh
}
