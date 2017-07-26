#!/bin/bash -x

SED=/usr/bin/sed

$SED 's/ResourceDisk.EnableSwap=n/ResourceDisk.EnableSwap=y/g' < /etc/waagent.conf > /etc/waagent-temp.conf
$SED 's/ResourceDisk.SwapSizeMB=0/ResourceDisk.SwapSizeMB=2048/g' < /etc/waagent-temp.conf > /etc/waagent.conf

rm /etc/waagent-temp.conf

systemctl restart waagent

exit 0