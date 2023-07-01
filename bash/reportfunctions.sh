#!/bin/bash
# This function is to get cpu information
function cpuinfo {
cat << EOF
CPU Report
==========

CPU Manufacturer:$(lscpu |grep -w 'Vendor ID' | {print$2})
CPU archtecture:$(lscpu |grep -w 'Architecture')
CPU core count:
CPU  maximum speed:
Size of Cachs:$(lscpu |grep -w 'Caches')



EOF 
}

# this function is to find computer information
function computerinfo {
cat << EOF

Computer Report
===============

computer manufacturer:(sudo dmidecode -s system-manufacturer)
computer description or model :$(sudo dmidecode -s system-product-name)
computer serial number:$(sudo dmidecode -s system-serial-number)

EOF

}

# this function is to find os information
function osinfo {
cat<<EOF
Os Report
=========
Operating System name and version= $(hostnamectl | grep -w 'Operating Sys>


EOF
}

# this function is to find  ram information
function raminfo {
cat<<EOF
RAM Report
=========
Root Filesysytem Free Space= $(df -h | grep -w '/' |awk '{print$4}')

EOF
}
