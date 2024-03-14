# VNC-Installation-Script-SUSE

```markdown
# VNC Installation and Configuration

This script automates the installation and configuration of VNC (Virtual Network Computing) on a GNOME Desktop environment in openSUSE using a Bash shell script.

## Prerequisites

Before running this script, ensure you have administrative privileges on the system.

## Steps

### Step 1: Install GNOME Desktop

Install the GNOME Desktop environment using the following command:

```bash
zypper install patterns-gnome-gnome_basic -y
```

### Step 2: Install and Configure VNC

Install the TigerVNC package for VNC functionality:

```bash
zypper install tigervnc -y
```

### Step 3: Copy the VNC Template Configuration File

Copy the VNC template configuration file to the appropriate location:

```bash
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
```

### Step 4: Update VNC Service Configuration

Add necessary configuration lines to the `vncserver@:1.service` file:

```bash
cat <<EOL >> /etc/systemd/system/vncserver@:1.service
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/sbin/runuser -l root -c "/usr/bin/vncserver %i -geometry 1280x1024"
PIDFile=/home/root/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'

[Install]
WantedBy=multi-user.target
EOL
```

### Step 5: Reload Systemd Configuration

Reload the systemd configuration to apply the changes:

```bash
systemctl daemon-reload
```

### Step 6: Enable and Start VNC Server

Enable and start the VNC server service:

```bash
systemctl enable vncserver@:1.service
systemctl start vncserver@:1.service
```

## Completion

The installation and configuration of VNC are now complete. Remember to set up a VNC password for users using the `vncpasswd` command.

```bash
vncpasswd
```

## Additional Information

For more information or troubleshooting, refer to the documentation of the respective packages and services.
```
This README.md provides a clear guide on how to install and configure VNC using the provided Bash script on openSUSE. It outlines the necessary steps, prerequisites, and additional information for users to successfully set up VNC on their system. Feel free to customize and improve this README as needed for your project or documentation purposes.
