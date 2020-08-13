#!/bin/bash

~/tools/pentestlab/pentestlab.sh stop bwapp
~/tools/pentestlab/pentestlab.sh stop dvwa
~/tools/pentestlab/pentestlab.sh stop juiceshop
~/tools/pentestlab/pentestlab.sh stop webgoat8
~/tools/pentestlab/pentestlab.sh stop webgoat7
~/tools/pentestlab/pentestlab.sh stop altoro
~/tools/pentestlab/pentestlab.sh stop mutillidae
~/tools/pentestlab/pentestlab.sh stop vulnerablewordpress
~/tools/pentestlab/pentestlab.sh stop securityninjas
rm -rf ~/.bash_history
history -c
poweroff
