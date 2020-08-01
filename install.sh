#!/bin/bash
#Получаем текущего пользователя и записываем в переменную VAR1
VAR1="user"

apt-get update -y
apt-get upgrade -y
apt-get install ssh -y
apt-get install curl gnupg nano wget ca-certificates apt-utils git apt-transport-https -y
curl -s https://syncthing.net/release-key.txt | apt-key add -
echo 'deb https://apt.syncthing.net/ syncthing stable' | tee /etc/apt/sources.list.d/syncthing.list
apt-get update
apt-get install syncthing
ufw allow 8384/tcp
ufw allow 22000/tcp
ufw allow 21027/udp
touch /etc/systemd/system/syncthing@.service
bash -c 'echo "[Unit]" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "Description=Syncthing - Open Source Continuous File Synchronization for %I" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "Documentation=man:syncthing(1)" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "After=network.target" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "[Service]" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "User=%i" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "ExecStart=/usr/bin/syncthing -no-browser -gui-address="0.0.0.0:8384" -no-restart -logflags=0" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "Restart=on-failure" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "SuccessExitStatus=3 4" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "RestartForceExitStatus=3 4" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "[Install]" >> /etc/systemd/system/syncthing@.service'
bash -c 'echo "WantedBy=multi-user.target" >> /etc/systemd/system/syncthing@.service'
sudo systemctl daemon-reload
sudo systemctl enable syncthing@${VAR1}
sudo systemctl start syncthing@${VAR1}
