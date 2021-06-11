Configure your kali as mine!

Pre-requisites:
Kali with xfce, bash and root

For activating root user in kali, follow the mentioned steps:
1. `sudo su`
2. `passwd`
3. Enter new root password.
4. Log out and re-login as root with the password.

For switching to bash shell in kali, follow the mentioned steps:
1. `kali-tweaks`
2. Shell & Prompt
3. Default Login Shell
4. Select Bash and apply.

Warning: Please move your data from desktop, download, documents, pictures , public, templates and videos folders before running the script as they will be deleted.

Steps to install:

1. Login as root user in kali with default installation.
2. `cd ~ && git clone https://github.com/thechiragjogani/dotfiles`
3. `cd dotfiles`
4. `chmod 777 *`
5. `./install.sh`
