# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Extensions to the standard Python datetime module"
HOMEPAGE="http://labix.org/python-dateutil https://pypi.python.org/pypi/python-dateutil"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="examples"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	sys-libs/timezone-data
	!<dev-python/python-dateutil-2.1"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# Use zoneinfo in /usr/share/zoneinfo.
	sed -i -e "s/zoneinfo.gettz/gettz/g" test.py || die

	# Fix parsing of date in non-English locales.
	sed -e 's/subprocess.getoutput("date")/subprocess.getoutput("LC_ALL=C date")/' \
		-i example.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" test.py || die
}

python_install() {
	distutils-r1_python_install

	rm -f "${D}$(python_get_sitedir)/dateutil/zoneinfo"/*.tar.*
}

python_install_all() {
	distutils-r1_python_install_all

	if use examples; then
		docinto examples
		dodoc example.py sandbox/*.py
	fi
}
