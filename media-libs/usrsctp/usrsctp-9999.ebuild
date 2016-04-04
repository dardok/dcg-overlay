EAPI=5

if [[ $PV = *9999* ]]; then
    KEYWORDS=""
    EGIT_BRANCH="master"
fi

inherit autotools eutils git-r3

DESCRIPTION="This is a userland SCTP stack supporting FreeBSD, Linux, Mac OS X and Windows."
HOMEPAGE="https://github.com/sctplab/usrsctp"

LICENSE="LGPL-2.1"
SLOT="0"
EGIT_REPO_URI="https://github.com/sctplab/usrsctp.git"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"
IUSE="dbus gstreamer gtk3 +introspection lz4 policykit pulseaudio python sasl smartcard static-libs usbredir vala webdav"

src_prepare() {
	epatch_user

	elibtoolize
	eaclocal
	eautoreconf
}
