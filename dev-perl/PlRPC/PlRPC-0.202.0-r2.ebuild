# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=MNOONING
MODULE_SECTION=${PN}
MODULE_VERSION=0.2020
inherit perl-module

S=${WORKDIR}/${PN}

DESCRIPTION="The Perl RPC Module"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=virtual/perl-Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/perldoc-remove.patch"
	  "${FILESDIR}/Security-notice-on-Storable-and-reply-attack.patch" )

src_test() {
	PERL_DL_NONLAZY=1 /usr/bin/perl \
		"-MExtUtils::Command::MM" \
		"-e" "test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
}
