# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=MIKER
MODULE_VERSION=4.066
inherit perl-module

DESCRIPTION="Manipulation and operations on IP addresses"

SLOT="0"
LICENSE="|| ( Artistic Artistic-2 )"
KEYWORDS="amd64"
IUSE="ipv6"

RDEPEND="ipv6? ( dev-perl/Socket6 )"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_prepare() {
	perl-module_src_prepare
	touch "${S}"/Makefile.old
}
