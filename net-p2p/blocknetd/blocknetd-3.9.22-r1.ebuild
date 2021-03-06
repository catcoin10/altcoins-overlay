# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BLOCK"
MY_PN="BlockDX"

inherit altcoin

HOMEPAGE="http://blocknet.co/"
SRC_URI="https://github.com/${COIN_NAME}DX/${MY_PN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples upnp +wallet zeromq libressl"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/univalue
	zeromq? ( net-libs/zeromq )
"

S="${WORKDIR}"/${MY_PN}-${PV}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	rm -r src/leveldb src/univalue
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-sys_univalue.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	append-ldflags -lunivalue
	local my_econf=
	has test $FEATURES || \
		my_econf="${my_econf} --disable-tests --disable-bench"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable zeromq zmq) \
		$(use_enable libressl) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--with-system-univalue \
		--with-system-libsecp256k1  \
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}

src_install() {
	mv src/${PN}xd src/${PN}
	altcoin_src_install
}
