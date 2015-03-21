<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>

# Shisharka home server

## services

* rsync daemon
	* started by ssh connection wth a special backup key
	* or started by `home_services` script
	* modules defined in rsyncd config
		* backups per user (in ~/backup of the user)
		* movies
		* music
		* pictures
* minidlna
* git repos - bare repos under `code/`
* apache
	* run sites from `~/sites`
	* separate copies from backup
		* owned by apache
		* contain deploy configuration (nice for testing)
	* [moin wiki](shisharka/)


Some services can be managed through the `home_services` script. A couple of examples:

	./home_services.sh rsync start

to start an rsync daemon (cannot be used with ssh pubkey, though)

	./home_services.sh minidlna status
	
well, to check the dlna status

## what it does

One motivating idea is not to have to start the various daemons as root. The daemons are started with configuration to

* write their pids in files in the `pids/` directory
* write logs in `logs/`

## TODO:

* get a fucking powered usb hub to use a harddrive
* all live code under source control
	* separate from backup 
	* only bare repos?
