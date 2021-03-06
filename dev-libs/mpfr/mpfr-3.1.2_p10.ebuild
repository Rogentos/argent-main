# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

# NOTE: we cannot depend on autotools here starting with gcc-4.3.x
inherit eutils libtool multilib multilib-minimal

MY_PV=${PV/_p*}
MY_P=${PN}-${MY_PV}
PLEVEL=${PV/*p}
DESCRIPTION="library for multiple-precision floating-point computations with exact rounding"
HOMEPAGE="http://www.mpfr.org/"
SRC_URI="http://www.mpfr.org/mpfr-${MY_PV}/${MY_P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/gmp-4.1.4-r2[${MULTILIB_USEDEP},static-libs?]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if [[ ${PLEVEL} != ${PV} ]] ; then
		local i
		for (( i = 1; i <= PLEVEL; ++i )) ; do
			epatch "${FILESDIR}"/${MY_PV}/patch$(printf '%02d' ${i})
		done
	fi
	find . -type f -exec touch -r configure {} +
	elibtoolize
}

multilib_src_configure() {
	# Make sure mpfr doesn't go probing toolchains it shouldn't #476336#19
	ECONF_SOURCE=${S} \
	user_redefine_cc=yes \
	econf \
		--docdir="\$(datarootdir)/doc/${PF}" \
		$(use_enable static-libs static)
}

multilib_src_install_all() {
	use static-libs || find "${ED}"/usr -name '*.la' -delete

	# clean up html/license install
	pushd "${ED}"/usr/share/doc/${PF} >/dev/null
	dohtml *.html && rm COPYING* *.html || die
	popd >/dev/null
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libmpfr$(get_libname 1)
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libmpfr$(get_libname 1)
}
