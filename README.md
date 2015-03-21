# home server

This is a simple init.d-style script to manage rsync and minidlna daemons.

Usage:
	
	./home_services {rsync|dlna} {start|stop|status}

This script was originally intended for a home server setup as described in [this article](http://monomon.me/protoblog/index.php/8-utils/1-setting-up-a-home-server-on-a-raspberry-pi).

## services

* rsync daemon
	* started by ssh connection wth a special backup key
	* modules defined in rsyncd config
		* backups per user
		* movies
		* music
		* pictures
* minidlna

## configuring the daemons

You need to install the programs:

	sudo apt-get install minidlna rsync

There are two example files included in `config/`. You can read the corresponding man entries with `man rsyncd.conf` and `man minidlna.conf` for more information.

You need to create `config/rsyncd.conf` and `config/minidlna.conf`, and set their options as needed.

Some services can be managed through the `home_services` script. A couple of examples:

	./home_services.sh rsync start

to start an rsync daemon (cannot be used with ssh pubkey, though)

	./home_services.sh dlna status
	
well, to check the dlna status

## what it does

One motivating idea is not to have to start the various daemons as root. The daemons are started with configuration to

* write their pids in files in the `pids/` directory
* write logs in `logs/`

## What it should do

Many other services can be potentially managed from here - apache, irc, owncloud, etc. TODO.