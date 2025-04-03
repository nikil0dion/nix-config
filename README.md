# NixOS Installation Guide with Btrfs and LUKS 24.11 😎

**Installing a minimal working image of nixos**

## 1. 🌐 Up Network Wi-Fi 

if you don't have nmcli ❗

```sh
# Check name wifi interface
ip a 

# Scan wifi names and Copy your wifi name
sudo iwlist wlp2s0 scan | grep ESSID

# Create file to connect your wifi
nano /tmp/wpa_supplicant.conf

# Paste this in file /tmp/wpa_supplicant.conf and Save it
network={
    ssid="Wifi_name"
    psk="Wifi_password"
}

# Replacing the template file with your configuration 
sudo mv /tmp/wpa_supplicant.conf /etc/wpa_supplicant.conf

# Connect to wifi 
sudo wpa_supplicant -B -i wlp2s0 -c /etc/wpa_supplicant.conf

# Setup DHCP client  
sudo dhclient wlp2s0

# Test network 
ping google.com
```
---

## 2. 📀 Disk UEFI partition 

as in the official instructions on nix.wiki ❗

```sh
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

all actions should be done in root ❗
su root ✈️

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

# 🔄 Create Swap on Btrfs size 4gb 
btrfs subvolume create /mnt/swap  
btrfs filesystem mkswapfile --size 4g --uuid clear /mnt/swap/swapfile  
swapon /mnt/swap/swapfile  

# 📦 Mount Boot and Filesystem
mount /dev/disk/by-label/NIXROOT /mnt  
mkdir -p /mnt/boot  
mount /dev/disk/by-label/NIXBOOT /mnt/boot  
```

---

## 4. ⚙️ Generate NixOS Config and download my configurations

```sh
# 🏗️ Generate configuration files  
sudo nixos-generate-config --root /mnt  

# 📂 Navigate to config directory  
cd /mnt/etc/nixos/

# Install wget and copy my configuration.nix and kernel 
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

