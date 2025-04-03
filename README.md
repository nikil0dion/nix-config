# NixOS Installation Guide with Btrfs and LUKS 😎

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

## 🛠️ Create Filesystem and Label Partitions  


```sh
# 📀 Label FAT  
lsblk  # Check your /dev/sdX
mkfs.fat -F 32 /dev/sdX1  
fatlabel /dev/sdX1 NIXBOOT  

# 🔒 Create LUKS Btrfs  
cryptsetup -y -v --type luks2 luksFormat /dev/sdX2  
cryptsetup luksOpen /dev/sdX2 space  
cryptsetup -v status space  
mkfs.btrfs /dev/mapper/space -L NIXROOT  

# 🔄 Create Swap on Btrfs size 4gb 
btrfs subvolume create /mnt/swap  
btrfs filesystem mkswapfile --size 4g --uuid clear /mnt/swap/swapfile  
swapon /mnt/swap/swapfile  

# 📦 Mount 
mount /dev/disk/by-label/NIXROOT /mnt  
mkdir -p /mnt/boot  
mount /dev/disk/by-label/NIXBOOT /mnt/boot  
```
