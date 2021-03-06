# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="DEM"
MY_PN=eMarkd

inherit versionator altcoin

HOMEPAGE="http://deutsche-emark.de/"
COMMIT="2e4533a2efc6fd44633f1af0802d3349c45ac985"
SRC_URI="https://github.com/${COIN_NAME}project/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MY_PN:0:-1}-${COMMIT}

src_prepare() {
	# local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/1.4-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}
