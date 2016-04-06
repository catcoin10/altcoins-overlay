# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit eutils autotools flag-o-matic

MY_PV="${PV}-multi"
COMMIT="ad3246c32598054addb687f9cc31155d4fd580a5"
DESCRIPTION="Multi-algo CPUMiner & Reference Cryptonote Miner (JSON-RPC 2.0)"
HOMEPAGE="https://github.com/tpruvot/${PN}"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}
	dev-libs/jansson
	dev-libs/openssl"

src_prepare() {
	replace-flags -O2 -O3
	replace-flags -march=i686 -march=native
	epatch "${FILESDIR}"/${PN}-1.1-curl-openssl.patch
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install
	newinitd "${FILESDIR}"/cpuminer.initd cpuminer
}
