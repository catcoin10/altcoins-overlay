# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
MyPN="BATA-SOURCE"

inherit versionator altcoin

MY_PV="CORE-$(get_version_component_range 2-3)-LINUX"
DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://www.bata.io/"
SRC_URI="https://github.com/BTA-${COIN_NAME}/${MyPN}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${MyPN}-${MY_PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --without-gui \
		  --disable-tests \
		  --without-daemon \
		  --with-utils
}

src_install() {
	dobin src/${PN}

	newman contrib/debian/manpages/bitcoin-cli.1 ${PN}.1
	newbashcomp contrib/bitcoin-cli.bash-completion ${PN}
}
