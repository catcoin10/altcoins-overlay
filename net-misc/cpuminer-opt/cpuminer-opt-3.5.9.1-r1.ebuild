# Copyright 2016-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit eutils autotools flag-o-matic

DESCRIPTION="Optimized multi algo CPU miner"
HOMEPAGE="https://github.com/JayDDee/${PN}"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}
	dev-libs/jansson
	dev-libs/openssl
	!net-misc/cpuminer-multi"

src_prepare() {
	replace-flags -O2 -O3
	replace-flags -march=x86-64 -march=native
	append-flags -std=c++11
	epatch "${FILESDIR}"/cpuminer-multi-1.1-curl-openssl.patch
	epatch "${FILESDIR}"/cpuminer-multi-1.2-hwmon_alt4.patch
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install
	newinitd "${FILESDIR}"/cpuminer.initd cpuminer
}
