# Global
export KEYTYPE=ecdsa
export PRIVATEKEY=id_${KEYTYPE}
export PUBLICKEY=${PRIVATEKEY}.pub
# New server
export USER=shaiou
echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" |sudo tee -a /etc/sudoers
sudo usermod -s zsh $USER
sudo systemctl enable sshd
sudo systemctl start sshd
mkdir ~/.ssh

# Existing machine
```
export HOMEDIR=/home/$USER
export MACHINE=bourriquet
export MACHINEIP=x.X.X.x
echo "$MACHINEIP $MACHINE" | sudo tee -a /etc/hosts
```
## SSH PART
```
scp ~/.ssh/$PUBLICKEY $USER@$MACHINE:$HOMEDIR/.ssh/authorized_keys
ssh $USER@$MACHINE ssh-keygen -t ${KEYTYPE} -f $HOMEDIR/.ssh/${PRIVATEKEY} -P "''"
ssh $USER@$MACHINE cat $HOMEDIR/.ssh/$PUBLICKEY | tee -a ~/.ssh.authorized_keys
```
Add key to [Github profile](https://github.com/settings/keys)
### The rest
ssh $USER@$MACHINE
```
git init
git remote add origin git@github.com:/shaiou/shaiou.git
git fetch
git checkout master
#git submodules update --init
#cshsh zsh
sudo usermod -aG docker shailendra
```

# fix screen flicker ??
sudo vi /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet  apparmor=1 security=apparmor udev.log_priority=3 intel_idle.max_cstate=1 i915.enable_dc=0 i915.enable_fbc=0"
sudo update-grub sync
reboot


## change default browser
sudo pacman -R palemoon

## Sound
systemctl  --user enable pulseaudio
systemctl  --user start pulseaudio
Add end of /etc/pulse/defauult.pa
```
# bluetooth thingy
load-module module-bluez5-discover
```

# home
xdg-settings set default-web-browser google-chrome.desktop

# boulot
xdg-settings set default-web-browser firefox.desktop
yay -Sy cloudflare-warp-bin
git config --global user.email "shailendra.narayen@believe.com"
git config --global user.name  "Shailendra Narayen"
#https://github.com/zaquestion/lab/releases

for plugin in python terraform terragrunt
do
  asdf plugin-add $plugin
  asdf install $plugin latest
  asdf global $plugin latest
done
## gitlab cli
wget https://github.com/zaquestion/lab/releases/download/v0.25.1/lab_0.25.1_linux_amd64.tar.gz
tar -zxvf lab_0.25.1_linux_amd64.tar.gz
sudo mv lab /usr/local/bin

# misc
warp-cli teams-enroll believe-intranet
warp-cli connect

## helm
helm plugin install https://github.com/databus23/helm-diff
