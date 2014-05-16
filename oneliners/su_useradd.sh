#!/bin/bash
#With sudo su
export NEWUSER=newuser; mkdir /home/$NEWUSER; useradd -d /home/$NEWUSER -s /bin/bash -G sudo $NEWUSER; passwd $NEWUSER
