# Simply NixOS Installation Guide with Btrfs and LUKS 26.05 😎

**Installing a minimal working image of nixos**

**🛑 No using Flakes**

## 1. 🌐 Up Network Wi-Fi 

if you don't have nmcli ❗

```sh
# 🔍 Check Wi-Fi interface name  
ip a  

# 📡 Scan available Wi-Fi networks and copy your network name  
sudo iwlist wlp2s0 scan | grep ESSID  

# 📝 Create a file to store Wi-Fi credentials  
nano /tmp/wpa_supplicant.conf  

# 📌 Paste this into the file `/tmp/wpa_supplicant.conf` and save it  
network={  
    ssid="Wifi_name"  
    psk="Wifi_password"  
}  

# 🔄 Replace the template file with your configuration  
sudo mv /tmp/wpa_supplicant.conf /etc/wpa_supplicant.conf  

# 🔗 Connect to Wi-Fi  
sudo wpa_supplicant -B -i wlp2s0 -c /etc/wpa_supplicant.conf  

# 🌍 Obtain an IP address using DHCP  
sudo dhclient wlp2s0  

# ✅ Test network connection  
ping google.com  

```
---

## 2. 📀 Disk UEFI partition 

as in the official instructions on nix.wiki ❗

```sh
sudo gdisk /dev/sdX

g (gpt disk label)
n
1 (partition number [1/128])
2048 first sector
+500M last sector (boot sector size)
t
1 (EFI System)
n
2
default (fill up partition)
default (fill up partition)
w (write)
```

---

## 3. 🛠️ Create Filesystem and Label Partitions  

all actions in root ❗

`su root` ✈️

```sh
# 📀 Label FAT  
lsblk  # Check your /dev/sdX
mkfs.fat -F 32 /dev/sdX1  
fatlabel /dev/sdX1 NIXBOOT  

# 🔒 Create LUKS Btrfs  
cryptsetup -y -v --type luks2 luksFormat /dev/sdX2  
cryptsetup luksOpen /dev/sdX2 space  
cryptsetup -v status space # Check it's ok
mkfs.btrfs /dev/mapper/space -L NIXROOT  

# 📦 Mount Boot and Filesystem
mount /dev/disk/by-label/NIXROOT /mnt  
mkdir -p /mnt/boot  
mount /dev/disk/by-label/NIXBOOT /mnt/boot  

# 🔄 Create Swap on Btrfs size 4gb 
btrfs subvolume create /mnt/swap  
btrfs filesystem mkswapfile --size 4g --uuid clear /mnt/swap/swapfile  
swapon /mnt/swap/swapfile  

```

---

## 4. ⚙️ Generate NixOS Config and download my configurations

```sh
# 🏗️ Generate configuration files  
sudo nixos-generate-config --root /mnt  

# 📂 Navigate to config directory  
cd /mnt/etc/nixos/

# 🪂 Install temporary wget and copy my configuration.nix and kernel 
nix-shell -p wget
wget https://raw.githubusercontent.com/nikil0dion/nix-config/refs/heads/main/nixos/configuration.nix
wget https://raw.githubusercontent.com/nikil0dion/nix-config/refs/heads/main/nixos/linux-kernel.nix
```
---

## 5. 🏗️ Install NixOS

```sh
cd /mnt
sudo nixos-install  
```

---

## 6. 🤠 Create user after installation

If you add a user via configuration.nix and then do a nixos-rebuild switch, you won't be able to login the user because it doesn't have a password, so it's easier to create the user the old way 👴

```sh
# 👤 Create a new user  
useradd -m -G wheel -s /bin/bash your_username  

# 🔑 Set a password for the user  
passwd your_username  

# 🔓 Grant sudo privileges (optional)  
echo "your_username ALL=(ALL) ALL" | sudo tee -a /etc/sudoers.d/your_username

# ✏️ Uncomment line an change your new username
nano /etc/nixos/configuration.nix

# 📦 Change Line Add user in group vboxusers
users.extraGroups.vboxusers.members = [ "your_username" ];

# 🐳 Change Line Add user in group docker
users.extraGroups.docker.members = [ "your_username" ];

# 🚀 And rebuild
nixos-rebuild switch
```
And restart your system and now login your new user 

---

## 7. 📦 Install Packages 

You can go 2 ways

1. Easy 😎
- go to the site `search.nixos.org/packages`
- find the desired package
- and install it `nix-env -iA nixos.dnf`

2. Hard 💪
```
# Create base home.nix
nano /etc/nixos/home.nix

# Paste and modify this template in /etc/nixos/home.nix
{ config, pkgs, ... }: {

  imports = [ ];

  home = {
      username = "your_username";  # 👤 Your username
      homeDirectory = "/home/your_username";  # 🏠 Home directory
      stateVersion = "24.11";  # 📅 State version
      packages = with pkgs; [
          # 🧑‍💻 ALL THE PROGRAMS YOU WANT TO INSTALL, SEARCH NIXOS PACKAGES 
          firefox  # 🌍 Firefox
          brave  # 🦸 Brave
          ...  # 🔄 Add other packages you need
      ];
   };
}

# 🚀 Of course need rebuild OS after and everything will be installed
nixos-rebuild switch --profile-name MyNixOS_v1.0
```

