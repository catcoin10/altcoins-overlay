# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
COIN_SYMBOL="PPC"
MY_CN="peercoin"

inherit altcoin

HOMEPAGE="http://peercoin.net/"
COMMIT="c10525d7bdcaaf3ea8febcdbb8659ef21c9da449"
SRC_URI="https://github.com/${MY_CN}/${MY_CN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

S="${WORKDIR}"/${MY_CN}-${COMMIT}