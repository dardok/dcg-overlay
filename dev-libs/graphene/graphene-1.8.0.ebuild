EAPI=6

inherit eutils meson

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
IUSE="cpu_flags_x86_sse2 arm_neon +gcc_vector +introspection +gobject_types tests benchmarks"

src_configure() {
	local emesonargs=(
		-Dsse2=$(usex cpu_flags_x86_sse2 true false)
		-Darm_neon=$(usex arm_neon true false)
		-Dgcc_vector=$(usex gcc_vector true false)
		-Dintrospection=$(usex introspection true false)
		-Dgobject_types=$(usex gobject_types true false)
		-Dtests=$(usex tests true false)
		-Dbenchmarks=$(usex benchmarks true false)
	)
    meson_src_configure
}
