#!/bin/bash -x

SED=/usr/bin/sed

$SED 's/ResourceDisk.EnableSwap=n/ResourceDisk.EnableSwap=y/g' < /etc/waagent.conf > /etc/waagent-temp.conf
$SED 's/ResourceDisk.SwapSizeMB=0/ResourceDisk.SwapSizeMB=6144/g' < /etc/waagent-temp.conf > /etc/waagent.conf

rm -f /etc/waagent-temp.conf

systemctl restart waagent

echo "
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
<IfModule mpm_prefork_module>
        StartServers             5
        MinSpareServers          5
        MaxSpareServers          10
        MaxClients               60
        MaxConnectionsPerChild   30
</IfModule>
" > /etc/httpd/conf.modules.d/00-mpm.conf
systemctl restart httpd

exit 0