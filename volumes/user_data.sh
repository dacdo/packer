#! /bin/bash
sudo mkfs -t xfs /dev/xvdb
sudo mkdir /mxlocal
sudo mount /dev/xvdb /mxlocal
sudo echo testing_user_data > /tmp/dac_user_data.txt