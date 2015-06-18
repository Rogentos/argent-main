# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=PHRED
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Perl module for Apache::Reload"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="www-apache/mod_perl"
DEPEND="${RDEPEND}"
