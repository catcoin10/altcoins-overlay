# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Connexion - API first applications with OpenAPI/Swagger and Flask"
HOMEPAGE="https://github.com/zalando/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test aiohttp ujson"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-2.5.1[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/inflection[${PYTHON_USEDEP}]
	dev-python/pathlib2[${PYTHON_USEDEP}]
	dev-python/typing[${PYTHON_USEDEP}]
	dev-python/clickclick[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/swagger-spec-validator[${PYTHON_USEDEP}]
	aiohttp? ( >=dev-python/aiohttp-2.3.10[${PYTHON_USEDEP}]
		dev-python/aiohttp-jinja2[${PYTHON_USEDEP}] )
	ujson? ( >=dev-python/ujson-1.35[${PYTHON_USEDEP}] )
"
