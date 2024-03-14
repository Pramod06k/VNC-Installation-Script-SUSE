
#!/bin/bash

# Step 1: Install GNOME Desktop
echo "Step 1: Install GNOME Desktop"
zypper install patterns-gnome-gnome_basic -y

# Step 2: Install and Configure VNC
echo "Step 2: Install and Configure VNC"
zypper install tigervnc -y

# Step 3: Copy the VNC template configuration file
echo "Step 3: Copy the VNC template configuration file"
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service

# Step 4: Add lines to "vncserver@:1.service" file
echo "Step 4: Add lines to 'vncserver@:1.service' file"

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

echo "Configuration for VNC service has been updated."

# Reload systemd configuration
systemctl daemon-reload

# Enable and start the VNC server
systemctl enable vncserver@:1.service
systemctl start vncserver@:1.service

echo "VNC installation and configuration complete."

# Additional information
echo "Remember to set up a VNC password for users. You can use 'vncpasswd' to set passwords for VNC users."

