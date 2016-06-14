# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="ANC"

inherit altcoin versionator

DESCRIPTION="Command-line JSON-RPC client for Anoncoin crypto-currency"
HOMEPAGE="https://anoncoin.net/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND+="virtual/bitcoin-leveldb"

src_prepare() {
	rm -r src/leveldb
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	econf --with-gui=no \
		  --disable-tests \
		  --without-daemon \
		  --without-libs \
		  --with-utils \
		  --with-system-leveldb
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/anoncoind" ||
		newman contrib/debian/manpages/${COIN_NAME}d.1 ${PN}.1

	newbashcomp contrib/${COIN_NAME}d.bash-completion ${PN}
}