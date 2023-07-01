#!/bin/bash
# This function is to get cpu information
function cpuinfo {
cat << EOF
CPU Report
==========

CPU information :lscpu


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

# this function is to find os information
function osinfo {
cat<<EOF
Os Report
=========
Linux distro:
Distro version:
EOF
}

# this function is to find  ram information
function raminfo {
cat info
RAM Report
=========

