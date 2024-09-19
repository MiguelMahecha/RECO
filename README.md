# RECO Virtual Machine Setup Tool
This tool simplifies the process of setting up virtual machines for our Computer Networks class. It was created in response to the common issues of VMs crashing, failing, or becoming corrupted. With RECO, we can quickly and reliably bootstrap new virtual machines, minimizing downtime and frustration.

# Features
* Platform-specific installation options (Slackware, Solaris, Windows)
* Automation of installation, configuration and maintenance of several programs (Eg. Samba, Bind9, Nginx, etc.)
* Error handling and logging

# Prerequisites
* Git: It's the easiest way to get the project and the scripts with minimal effort.
* Bash: The project is written and tested using bash, no official support for other shells.
* Sudo or Root privileges: Since the program is going to be installing apps, and editing system files, you'll need root permissions

# Installation
Just clone the repo, make the install.sh runable, and run it
```bash
git clone https://github.com/MiguelMahecha/RECO.git
cd ./RECO
chmod u+x ./install.sh
```

# Usage
* Basic usage, run the script and choose which OS you're setting up
```bash
./install.sh --slackware
```

* For a list of supported OSes and commands
```bash
./install.sh --help
```