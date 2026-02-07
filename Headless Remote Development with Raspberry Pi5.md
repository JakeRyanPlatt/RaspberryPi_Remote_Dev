By: Jacob Platt
# Table of Contents
---
1. Introduction and prerequisites to Raspberry Pi Setup
2. Hardware assembly and component identification
3. Operating system installation (Raspberry Pi OS Lite)
4. Initial system configuration
5. Network configuration
6. SSH setup and security
7. VS Code remote development setup
8. Testing and verification
9. Next steps and resources
---

# 



# 1.
# 2.
# 3.
# 4.
# 5.

# 6.
# 7.  Pi VSCode Download/ Extension

1. **Install the Remote - SSH Extension in VS Code**
    - Open VS Code on your computer.
    - Go to the Extensions view (`Ctrl+Shift+X or Cmd+Shift+X`).
    - Search for "Remote - SSH" and install the extension published by Microsoft.
    - A new remote icon (a network plug) will appear in your left sidebar.
2. **Connect to Your Raspberry Pi**
    - Click on the Remote Explorer icon in the sidebar.
    - Hover over the **SSH** section and click the `+` icon to add a new host.
    - Enter the SSH connection command using your Pi's credentials: `ssh <username>@<hostname_or_ip_address>` (e.g., `ssh pi@raspberrypi.local` or `ssh pi@192.168.1.100`).
    - Press Enter and select a configuration file when prompted (usually the default user folder one). The host is now saved.
3. **Establish the Connection**
    - In the Remote Explorer, under the SSH menu, find your new host entry.
    - Click the "Connect to host in new window" icon (looks like a new window next to the host name).
    - A new VS Code window will open and attempt to connect.
    - If prompted to confirm the host's authenticity, type `yes` in the terminal.
    - Enter your Raspberry Pi's password when requested.
4. **Start Coding Remotely**
    - Once connected, the green bar in the bottom-left corner of the VS Code window will indicate the active SSH connection.
    - In the Explorer sidebar, click **Open Folder**. A file explorer for your Raspberry Pi's file system will appear.
    - Navigate to your desired project folder (e.g., `/home/pi/Documents`) and click **OK**.
    - You can now create, edit, and run files directly on the Raspberry Pi using the familiar VS Code interface and its integrated terminal. Any command run in the terminal executes on the Pi itself. 
- [](https://code.visualstudio.com/docs/remote/ssh)
    
    Remote Development using SSH - Visual Studio Code
    
    Installation. To get started, you need to: Install an OpenSSH compatible SSH client if one is not already present. Install Visual ...
    
    ![](data:image/png;base64,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)
    
    Visual Studio Code
    
### 