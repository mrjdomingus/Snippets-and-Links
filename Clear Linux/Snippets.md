# How to install native Visual Code on Clear Linux

_First install Clear Linux games bundle_<br>
`swupd bundle-add games` # (required for libgconf-2)

Download `.tar.gz` for Linux x64 from https://code.visualstudio.com/ and extract to `/opt/vscode`.<br> _[This needs to be fleshed out more...]_

Create symlink: `sudo ln -s /opt/vscode/code /usr/local/bin/code`

Add VS Code icon to GNOME by creating a desktop file:<br>
`sudo nano /usr/local/share/applications/code.desktop`

Enter the following contents in the file:
```
[Desktop Entry]
Version=1.0
Name=Visual Studio Code
Type=Application
Exec=/usr/local/bin/code
Icon=/opt/vscode/resources/app/resources/linux/code.png
Comment=Custom definition for VS Code
```

After adding the desktop file, you will need to run:<br>
`update-desktop-database` 

### Relevant links
* [How to create desktop shortcut launcher on Ubuntu 18.04 Bionic Beaver Linux](https://linuxconfig.org/how-to-create-desktop-shortcut-launcher-on-ubuntu-18-04-bionic-beaver-linux#h6-3-desktop-shortcut-creation-with-gnome-desktop-item-edit)
* [How to create custom launcher in gnome desktop](https://community.clearlinux.org/t/how-to-create-custom-launcher-in-gnome-desktop/596)
* [Clear Linux Desktop Setup](https://openwebcraft.com/notes/clearlinux-desktop-setup/)
* [Desktop files: putting your application in the desktop menus](https://developer.gnome.org/integration-guide/stable/desktop-files.html.en)
* [Introduction to Desktop File Utils](http://www.linuxfromscratch.org/blfs/view/svn/general/desktop-file-utils.html)
* [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html)
* [Need native support for VS Code through swupd](https://community.clearlinux.org/t/need-native-support-for-vs-code-through-swupd/1112/10)
