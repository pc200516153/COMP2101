
#!/bin/bash
echo  "FQDN:"
hostname --fqdn
echo "Host Infornation"
hostnamectl
echo "IP Addressses:"
hostname -I
echo "Root Filesysytem Status:"
df -h | head -1
df -h | grep -w '/'
