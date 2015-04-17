# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Manage multiple Gradle versions on one system"
HOMEPAGE="http://www.argentlinux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="app-eselect-eselect"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/eselect/modules
	doins "${FILESDIR}"/gradle.eselect
}
