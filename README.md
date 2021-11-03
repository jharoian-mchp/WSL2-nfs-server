# WSL2-nfs-server Project

The project enables a user to easily create and setup an nfs server on Windows for use in conjunction with Windows Subsystem for Linux 2 (WSL2).

## Requirements

- Windows 10 or higher computer with WSL2 installed
- VirtualBox installed
- Vagrant installed (see below)
- This project

## Notes on installing VirtualBox

### Latest Version not compatible with Hyper-V

As of November 3, 2021, the latest version of VirtualBox (v6.1.28) is not compatible with Hyper-V (needed for WSL2).  Please use VirtualBox v6.1.26 until this is addressed.  The older version can be found here:

[Download_Old_Builds_6_1 – Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Download_Old_Builds_6_1)

### Installing Extension Pack

To install VirtualBox Extension Pack, launch VirtualBox as administrator.  Install the Extension Pack and then exit.  If the attempt to install the Extension Pack is made without running as administrator, the process will fail.

The Extension Pack requires an Oracle License.  It is not needed for this project.  If you need the Extension Pack, use Service-Now to request a license.  If you are a member of the Embedded Software Function Group then a license has been allocated.

## Install Vagrant

Head to Vagrant's download page at [Downloads | Vagrant by HashiCorp (vagrantup.com)](https://www.vagrantup.com/downloads)

Select 64 bit and install as any Windows program

Test at command line (cmd.exe) from within the project folder:

```
c:\Projects\wsl2-nfs-server>vagrant -v
Vagrant 2.2.18
```

## Using Vagrant

### Start WSL2-nfs-server

To start the WSL2-nfs-server, start a command line from within the project folder and type the following command and wait.  Each time the computer starts or reboots, vagrant will be used to start the nfs-server.  The launch time will shorten.

```
c:\Projects\wsl2-nfs-server>vagrant up
Bringing machine 'nfs-server' up with 'virtualbox' provider...
==> nfs-server: Importing base box 'debian/bullseye64'...
==> nfs-server: Matching MAC address for NAT networking...
==> nfs-server: Checking if box 'debian/bullseye64' version '11.20211018.1' is up to date...
==> nfs-server: Setting the name of the VM: wsl2-nfs-server_nfs-server_1635969955379_18909
==> nfs-server: Clearing any previously set network interfaces...
==> nfs-server: Available bridged network interfaces:
1) Realtek USB GbE Family Controller
2) Hyper-V Virtual Ethernet Adapter
3) Hyper-V Virtual Ethernet Adapter #2
4) Cisco AnyConnect Secure Mobility Client Virtual Miniport Adapter for Windows x64
==> nfs-server: When choosing an interface, it is usually the one that is
==> nfs-server: being used to connect to the internet.
==> nfs-server:
    nfs-server: Which interface should the network bridge to?
```

At this prompt, choose your physical connection to the internet.  In this case, it is #1

```
... lots of info on the state of the vm being update and configured ...
    nfs-server: First installation detected...
    nfs-server: Checking NSS setup...
    nfs-server: Setting up libgtk-3-common (3.24.24-4) ...
    nfs-server: Setting up libpangocairo-1.0-0:amd64 (1.46.2-3) ...
    nfs-server: Setting up gsettings-desktop-schemas (3.38.0-2) ...
    nfs-server: Setting up libpangoxft-1.0-0:amd64 (1.46.2-3) ...
    nfs-server: Setting up avahi-utils (0.8-5) ...
    nfs-server: Setting up librsvg2-2:amd64 (2.50.3+dfsg-1) ...
    nfs-server: Setting up gir1.2-pango-1.0:amd64 (1.46.2-3) ...
    nfs-server: Setting up librsvg2-common:amd64 (2.50.3+dfsg-1) ...
    nfs-server: Processing triggers for libglib2.0-0:amd64 (2.66.8-1) ...
    nfs-server: Processing triggers for libc-bin (2.31-13+deb11u2) ...
    nfs-server: Processing triggers for man-db (2.9.4-2) ...
    nfs-server: Processing triggers for dbus (1.12.20-2) ...
    nfs-server: Setting up glib-networking:amd64 (2.66.0-2) ...
    nfs-server: Processing triggers for mailcap (3.69) ...
    nfs-server: Setting up libsoup2.4-1:amd64 (2.72.0-2) ...
    nfs-server: Setting up libsoup-gnome2.4-1:amd64 (2.72.0-2) ...
    nfs-server: Setting up librest-0.7-0:amd64 (0.8.1-1.1) ...
    nfs-server: Setting up libgtk-3-0:amd64 (3.24.24-4) ...
    nfs-server: Setting up gir1.2-gtk-3.0:amd64 (3.24.24-4) ...
    nfs-server: Setting up libgtk-3-bin (3.24.24-4) ...
    nfs-server: Setting up avahi-discover (0.8-5) ...
    nfs-server: Processing triggers for libgdk-pixbuf-2.0-0:amd64 (2.42.2+dfsg-1) ...
    nfs-server: Processing triggers for libc-bin (2.31-13+deb11u2) ...
    nfs-server: <service-group>
    nfs-server:   <name replace-wildcards="yes">NFS share on %h</name>
    nfs-server:   <service>
    nfs-server:     <type>_nfs._tcp</type>
    nfs-server:     <port>2049</port>
    nfs-server:     <txt-record>path=/srv/export/images</txt-record>
    nfs-server:   </service>
    nfs-server: </service-group>
    nfs-server: [IP address:192.168.1.227]

==> nfs-server: Machine 'nfs-server' has a post `vagrant up` message. This is a message
==> nfs-server: from the creator of the Vagrantfile, and not from Vagrant itself:
==> nfs-server:
==> nfs-server: Vanilla Debian box. See https://app.vagrantup.com/debian for help and bug reports

C:\Projects\wsl2-nfs-server>
```

Note that the IP address is listed in the information above.  The Vagrantfile can be edited to use a static IP address.  The default receives an IP address from the DHCP server.

At this point, the nfs server is up and ready to use.  Now install the WSL2-nfs-client on WSL2 to complete the setup.

## Useful Vagrant Commands

The remaining Vagrant commands are useful for extending the solution and other experimentation.  Also, if any ever goes wrong, the VM can be destroyed and the setup done again.

### Access WSL2-nfs-server

Accessing the virtual machine directly should not be necessary, but if there is a need use the following command:

```
vagrant ssh
```

### Halt WSL2-nfs-server

To stop the virtual machine from running use the following command:

```
vagrant halt
```

### Destroy WSL2-nfs-server

To remove virtual machine use the following:

```
vagrant destroy
```

------

Copyright © 2021 John Haroian
