#!/sbin/runscript
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

if [ "${SVCNAME}" = "puppetmaster" ] ; then
	PUPPETMASTER_PID="master"
else
	PUPPETMASTER_PID="${SVCNAME#*.}"
fi
PUPPETMASTER_PID_DIR="${PUPPETMASTER_PID_DIR:-/var/run/puppet}"
pidfile="${PUPPETMASTER_PID_DIR}/${PUPPETMASTER_PID}.pid"
PUPPET_LOG_DIR="/var/log/puppet"

command_args="master --pidfile ${pidfile} --confdir /etc/puppetlabs/puppet ${PUPPETMASTER_EXTRA_OPTS}"
if [ -n "${PUPPETMASTER_PORT}" ] ; then
	command_args="${command_args} --masterport ${PUPPETMASTER_PORT}"
fi

command="/usr/bin/puppet"

depend() {
	need localmount
	use dns logger slapd netmount nfsmount
}

start_pre() {
	checkpath --directory --owner puppet:puppet "${PUPPETMASTER_PID_DIR}"
	checkpath --directory --owner puppet:puppet --mode 750 ${PUPPET_LOG_DIR}
	checkpath --file --owner puppet:puppet --mode 640 "${PUPPET_LOG_DIR}/masterhttp.log"
}
