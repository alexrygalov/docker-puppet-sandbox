#!/bin/bash

certname="$(hostname | cut -d "." -f1 | tr '[:upper:]' '[:lower:]')"

# startOnBoot=$(cat /etc/default/puppet | grep -c START=yes)

cat > /etc/puppetlabs/puppet/puppet.conf << EOL
[main]
certname = $certname.example.com
server = puppetmaster
environment = production
runinterval = 15m
EOL

### set puppet server
echo '10.211.55.73 puppetmaster puppetmaster.example.com' >> /etc/hosts

#Changed to START=yes
#Enable starting puppet with service
# if (($startOnBoot == 0)); then
#   sed -i.bak s/START=no/START=yes/g /etc/default/puppet
# fi

#Start puppet agent
# service puppet start

/usr/sbin/sshd -D
