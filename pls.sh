#!/bin/bash

#####################################################
##        Author: Mehraj Patel     ##
#### note - Dont remove this section else this script won't run ;) ####
#####################################################


#username should be provided as command line parameter
username=$1

cat $HOME/.ssh/authorized_keys >> authorized_keys
for i in `cat $HOME/hosts`
do
 ssh -i key.pem $username@$i "echo -e 'y\n' | ssh-keygen -t rsa -P '' -f $HOME/.ssh/id_rsa"
 ssh -i key.pem $username@$i 'touch ~/.ssh/config; echo -e \ "host *\n StrictHostKeyChecking no\n UserKnownHostsFile=/dev/null" \ > ~/.ssh/config; chmod 644 ~/.ssh/config'
 ssh -i key.pem $username@$i 'cat $HOME/.ssh/id_rsa.pub' >> authorized_keys
done

for i in `cat $HOME/hosts`
do
 scp -i key.pem authorized_keys $username@$i:$HOME/.ssh/authorized_keys
done
