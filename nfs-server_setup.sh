#!/bin/sh

# WSL2-nfs-server setup script
#
# Configures vagrant virtual machine to be an nfs server
# Used for embedded development on Linux based MPUs
# and WSL2 for a Linux host
#
# Specifically solves the problem with WSL2 networking
# Embedded board can communicate with the nfs server
# if not located inside WSL2
#
# WSL2 needs to have a nfs client to talk to this server
# See WSL2-nfs-client project
#
#
# John Haroian - c14029
# Microchip
# November 3, 2021

# Context for script execution is with sudo

echo "[Updating via apt]"
apt-get -qq update
apt-get -qq upgrade
echo "[Setting timezone to Pacific]"
timedatectl set-timezone America/Los_Angeles
echo "[Installing NFS Server]"
apt-get -qq install nfs-kernel-server
mkdir -p /srv/export/images
chown -R nobody: /srv/export/images
chmod -R 777 /srv/export/images
cat << _EXPORT | tee --append /etc/exports
/srv/export/images *(rw,no_all_squash,no_root_squash,no_subtree_check,insecure)
_EXPORT
exportfs -arv
echo "[Install Avahi (Bonjour)]"
apt-get -qq install avahi-daemon avahi-discover avahi-utils libnss-mdns mdns-scan
cat << _SERVICE | tee /etc/avahi/services/nfs.service
<service-group>
  <name replace-wildcards="yes">NFS share on %h</name>
  <service>
    <type>_nfs._tcp</type>
    <port>2049</port>
    <txt-record>path=/srv/export/images</txt-record>
  </service>
</service-group>
_SERVICE
IP_ADDR=$(ip a | grep -E -o "(192\.)([0-9]{1,3}\.)([0-9]{1,3}\.)([0-1][0-9][0-9]|2[0-4][0-9]|25[0-4])")
echo "[IP address:${IP_ADDR}]" 
