Vagrant Windows Boxes and Puppet
============================

## Prerequisites
### Note - This is my own fork of what ferventcoder has done. I wanted to build my own box and get an idea of what he was doing. 
### For more info please visit - https://github.com/ferventcoder/vagrant-windows-puppet

 * [Vagrant 1.7.2](https://www.vagrantup.com/downloads.html)
 * [VirtualBox 4.3.22](https://www.virtualbox.org/wiki/Downloads) 
 * At least 20GB free on the host box.

 ## Building Windows Boxes for Vagrant 
 You can follow either of these guides to get an idea:
 * [vagrant-windows](https://github.com/WinRb/vagrant-windows#creating-a-base-box)
 * [thomasvjames](http://www.thomasvjames.com/2013/09/create-a-windows-base-box-for-vagrant)

 I took it upon myself to build a box using the 2012R2 Evaluation version of Windows. I also only followed parts of this guide which was useful and is essentially what ferventcoder also has done. 
 I didn't even do the scripted import into VirtualBox. I just imported the VHD and tried to do as little as possible to the OS. So based on the above link I did the following:
 1. Impmort the VHD.
 2. Set Administrator password to Pass@word1
 3. Set the Timezone.
 4. Install the VirtualBox Guest Additions.
 5. Run the vagrant_prepare.ps1 script. Also stored in C:\Temp on the image.
 6. Shutdown the VM so that a vagrant base box can be created.
 7. Then just follow the commands to create the box.
 8. Once the box is created, you can place it anywhere. I put mine on VagrantCloud - https://vagrantcloud.com (It's a private box so no you can't have access. Make sure you change that in your vagrant file or it will fail.)

## Setup

 1. Install/upgrade Vagrant to versions listed above.
 2. Install/upgrade VirtualBox/VMWare to versions listed above.
 3. Install/upgrade required plugins for vagrant (if using VMWare you will need the non-free vagrant-vmware-fusion or equivalent).
 5. Take a look at this gist that might be helpful in determining commands to call for setup: [Install Vagrant Windows Environment](https://gist.github.com/ferventcoder/6251225)

## Boxes Folder

 1. Create the `puppet/modules` and `puppet/box_modules` directories in each `boxes` directory that you want to use vagrant in (if it doesn't already exist).
 2. In each folder if you are running VirtualBox, you can just `vagrant up`. If you are running VMWare, you will want to `vagrant up --provider=vmware_fusion`.
