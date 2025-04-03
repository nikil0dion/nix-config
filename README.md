# NixOS Installation Guide with Btrfs and LUKS 😎

## 1. 🌐 Up Network Wi-Fi 

If you don't have nmcli ❗

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
