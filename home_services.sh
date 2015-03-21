#!/bin/bash

rootdir=`pwd`

piddir=$rootdir/pids
daemonuser=pi

daemonname="$1"
command="$2"

pidfile=${piddir}/${daemonname}.pid

start_it() {
	if [ -e ${pidfile} ]; then
		echo "${daemonname} already running"
		exit 1
	fi

	case ${daemonname} in
		# this one called when a client contacts us
		remote_rsync)
			rsync --server --daemon --config=$rootdir/config/rsyncd.conf .
			exit 0
			;;
		rsync)
			rsync --daemon --config=$rootdir/config/rsyncd.conf
			;;
		dlna)
			minidlna -f $rootdir/config/minidlna.conf -P ${pidfile}
			exit 0
			;;
		*)
			echo "unknown service, ignoring"
			exit 1
			;;
	esac
}

stop_it() {
	if [ ! -e ${pidfile} ]; then
		echo "pidfile not found... nothing to do"
		exit 1
	fi

	kill `cat ${pidfile}`
}

get_status(){
	if [ -e ${pidfile} ]; then
			echo "${daemonname} is running at `cat ${pidfile}`"
	else
			echo "${daemonname} is not running"
	fi
}

build_readme(){
	if [ ${daemonname} == "readme" ]; then
			echo "compiling docs..."
			markdown README.md > README.html
			echo "copying docs..."
			cp README.html /var/www/index.html
			chown www-data:www-data /var/www/index.html
			if [ $? == 0 ]; then
				echo "docs ready"
			else
				echo "problem copying docs!"
				exit 1
			fi
	fi
}

case "${command}" in
	start)
		start_it
		;;
	stop)
		stop_it
		;;
	status)
		get_status
		;;
	install)
		build_readme
		;;
	*)
		echo "usage: $0 {rsync|dlna} {start|stop|status}"
		;;
esac

