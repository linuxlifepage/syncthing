# PLEASE CHECK YOUR PATH DIRECTORY NEXTCLOUD /var/snap/nextcloud/common/nextcloud/data/user/files/

rsync --delete --partial --append-verify -av /var/snap/nextcloud/common/nextcloud/data/user/files/ /home/user/Sync/NextCloud
chown -R user:user /home/user/Sync/NextCloud
chmod -R 750 /home/user/Sync/NextCloud 
