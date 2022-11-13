# Bash LAMP
<img src="https://user-images.githubusercontent.com/26361520/201491021-d1277740-83cb-4e04-86b8-99703b62565c.png" width="600" />

*Sets up a LAMP server with users, FTP access and a WordPress instance.*

## What it does?
Concretely, this script does the following:
- Updates the system
- Enables SELinux
- Sets up Byobu (a Tmux replacement)
- Sets up a fancy banner (see pic above)
- Creates new users
- Sets up a LAMP server
- Sets up a VSFTP server with SSL certificates
  - See also: [RHEL 5 Manual: vsftpd Configuration Options](https://web.mit.edu/rhel-doc/5/RHEL-5-manual/Deployment_Guide-en-US/s1-ftp-vsftpd-conf.html)
- Sets up Wordpress w/ WooCommerce plugin ready to be installed
- Sets up Fail2Ban

## Usage
- `git clone https://github.com/blue-hexagon/BashLamp`
- `cd BashLamp`
- `chmod 644 * ; chmod 744 main.sh`
- As root: `./main.sh`
- As any other user: `sudo ./main.sh`

