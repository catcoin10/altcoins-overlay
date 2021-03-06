# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

MY_PN=python-${PN}
MY_P=${MY_PN}-${PV}
DESCRIPTION="The Swiss Army Knife of the Bitcoin protocol"
HOMEPAGE="https://github.com/petertodd/${MY_PN}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3+"
KEYWORDS="~x86 ~amd64"
SLOT="0"

S="${WORKDIR}"/${MY_P}
