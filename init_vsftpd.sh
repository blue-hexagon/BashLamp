#!/bin/bash    
source func_colors.sh

print_yellow "For resources: https://techviewleo.com/install-and-configure-vsftpd-ftp-server-on-rocky-linux/#comments"

dnf install -y vsftpd openssl
systemctl enable --now vsftpd

firewall-cmd --zone=public --permanent --add-port=21/tcp
firewall-cmd --zone=public --permanent --add-port=30000-31000/tcp
firewall-cmd --zone=public --permanent --add-service=ftp

firewall-cmd --reload

adduser vsftpduser
passwd --stdin vsftpduser <<< "Kodeord1234!!!"


mkdir -p /home/vsftpduser/ftp_folder
chmod -R 750 /home/vsftpduser/ftp_folder
chown vsftpduser: /home/vsftpduser/ftp_folder


echo 'vsftpduser' >> /etc/vsftpd/user_list

sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' /etc/vsftpd/vsftpd.conf

echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf
echo "pasv_min_port=30000" >> /etc/vsftpd/vsftpd.conf
echo "pasv_max_port=31000" >> /etc/vsftpd/vsftpd.conf
echo "userlist_file=/etc/vsftpd/user_list" >> /etc/vsftpd/vsftpd.conf
echo "userlist_deny=NO" >> /etc/vsftpd/vsftpd.conf

#sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/vsftpd.pem -out /etc/vsftpd/vsftpd.pem

#echo "rsa_cert_file=/etc/vsftpd/vsftpd.pem" >> /etc/vsftpd/vsftpd.conf
#echo "rsa_private_key_file=/etc/vsftpd.pem" >> /etc/vsftpd/vsftpd.conf
#echo "ssl_enable=YES" >> /etc/vsftpd/vsftpd.conf

systemctl restart vsftpd
