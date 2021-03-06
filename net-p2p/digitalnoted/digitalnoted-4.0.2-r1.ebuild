# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="XDN"
COIN_FAMILY="cryptonote"
MY_PV=${PV}-beta

inherit versionator altcoin cmake-utils

HOMEPAGE="http://digitalnote.org/"
SRC_URI="https://github.com/xdn-project/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="+wallet"

DEPEND+="dev-lang/python
	net-libs/miniupnpc"

PVM=$(get_version_component_range 1-2)

PATCHES=(
	"${FILESDIR}"/${PVM}-miniupnpc-dynamic.patch
	"${FILESDIR}"/${PVM}-iostream.patch
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUPNP_STATIC=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	local target=Daemon
	use wallet && target=PaymentGateService
	has test $FEATURES || cmake_comment_add_subdirectory tests
	cmake-utils_src_compile $target
}

src_install() {
	if use wallet; then
		newbin ${BUILD_DIR}/src/walletd ${COIN_NAME}_walletd
	else
		dobin ${BUILD_DIR}/src/${PN}
	fi
	altcoin_install_inf
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
