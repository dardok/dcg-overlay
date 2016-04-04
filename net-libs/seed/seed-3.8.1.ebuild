EAPI=5

inherit autotools eutils

DESCRIPTION="Seed is a library and interpreter, dynamically bridging (through GObjectIntrospection) the WebKit JavaScriptCore engine, with the GNOME platform."
HOMEPAGE="https://wiki.gnome.org/action/show/Projects/Seed"

LICENSE="LGPL-2.1"
SLOT="0"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/seed/3.8/seed-3.8.1.tar.xz"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86"
RDEPEND="
  x11-libs/cairo
  dev-db/sqlite"
