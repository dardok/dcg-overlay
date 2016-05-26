# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 python3_4 )

inherit distutils-r1 eutils git-r3 linux-info user

DESCRIPTION="Heat is the OpenStack Orchestration service"
HOMEPAGE="https://launchpad.net/heat"
EGIT_REPO_URI="https://github.com/openstack/heat.git"
EGIT_BRANCH="stable/mitaka"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+api"
REQUIRED_USE="|| ( mysql postgres sqlite )"

CDEPEND=">=dev-python/pbr-1.6[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	${CDEPEND}"

RDEPEND="
	${CDEPEND}
	>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
	>=dev-python/croniter-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.0[${PYTHON_USEDEP}]
	!~dev-python/cryptography-1.3[${PYTHON_USEDEP}]
	>=dev-python/debtcollector-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/eventlet-0.18.2[${PYTHON_USEDEP}]
	!~dev-python/eventlet-0.18.3[${PYTHON_USEDEP}]
	>=dev-python/greenlet-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/keystonemiddleware-4.0.0[${PYTHON_USEDEP}]
	!~dev-python/keystonemiddleware-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.12[${PYTHON_USEDEP}]
	!~dev-python/netaddr-0.7.16[${PYTHON_USEDEP}]
	>=dev-python/oslo-cache-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-3.7.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-concurrency-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-context-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-db-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-log-1.14.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-messaging-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-middleware-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-policy-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-reports-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-serialization-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-service-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-utils-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/oslo-versionedobjects-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/osprofiler-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/paramiko-1.16.0[${PYTHON_USEDEP}]
	dev-python/paste[${PYTHON_USEDEP}]
	>=dev-python/pastedeploy-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/python-barbicanclient-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/python-ceilometerclient-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/python-designateclient-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/python-glanceclient-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-heatclient-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/python-keystoneclient-1.6.0[${PYTHON_USEDEP}]
	!~dev-python/python-keystoneclient-1.8.0[${PYTHON_USEDEP}]
	!~dev-python/python-keystoneclient-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-neutronclient-2.6.0[${PYTHON_USEDEP}]
	!~dev-python/python-neutronclient-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-novaclient-2.29.0[${PYTHON_USEDEP}]
	!~dev-python/python-novaclient-2.33.0[${PYTHON_USEDEP}]
	>=dev-python/python-openstackclient-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-swiftclient-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/pytz-2013.6[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.8.1[${PYTHON_USEDEP}]
	!~dev-python/requests-2.9.0[${PYTHON_USEDEP}]
	>=dev-python/retrying-1.2.3[${PYTHON_USEDEP}]
	!~dev-python/retrying-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/routes-1.12.3[${PYTHON_USEDEP}]
	!~dev-python/routes-2.0[${PYTHON_USEDEP}]
	!~dev-python/routes-2.1[$(python_gen_usedep 'python2_7')]
	>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
	sqlite? (
		>=dev-python/sqlalchemy-1.0.10[sqlite,${PYTHON_USEDEP}]
		<dev-python/sqlalchemy-1.1.0[sqlite,${PYTHON_USEDEP}]
	)
	mysql? (
		dev-python/mysql-python
		>=dev-python/sqlalchemy-1.0.10[${PYTHON_USEDEP}]
		<dev-python/sqlalchemy-1.1.0[${PYTHON_USEDEP}]
	)
	postgres? (
		dev-python/psycopg:2
		>=dev-python/sqlalchemy-1.0.10[${PYTHON_USEDEP}]
		<dev-python/sqlalchemy-1.1.0[${PYTHON_USEDEP}]
	)
	>=dev-python/sqlalchemy-migrate-0.9.6[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/webob-1.2.3-r1[${PYTHON_USEDEP}]"

# python-magnumclient>=0.2.1 # Apache-2.0
# python-manilaclient>=1.3.0 # Apache-2.0
# python-mistralclient>=1.0.0 # Apache-2.0
# python-saharaclient>=0.13.0 # Apache-2.0
# python-senlinclient>=0.3.0 # Apache-2.0
# python-troveclient!=2.1.0,>=1.2.0 # Apache-2.0
# python-zaqarclient>=0.3.0 # Apache-2.0

#PATCHES=(
#)

pkg_setup() {
	linux-info_pkg_setup
	enewgroup heat
	enewuser heat -1 -1 /var/lib/heat heat
}

python_prepare_all() {
	sed -i '/^hacking/d' test-requirements.txt || die
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install
	keepdir /etc/heat

	insinto /etc/heat
	insopts -m0640 -o cinder -g cinder
	doins "etc/heat/api-paste.ini"
	doins "etc/heat/policy.json"
	insinto /etc/cinder/environment.d
	newins "etc/heat/environment.d/default.yaml"

	dodir /var/log/heat
	fowners heat:heat /var/log/heat
}
