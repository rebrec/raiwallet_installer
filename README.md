# RaiBlocks Wallet Installer for Linux


As asked by a friend,
Here is an easy to use script that will install the required dependancies to run the RaiBlocks wallet under linux

Currently i have concentrated on making it work on Ubuntu since most of new linux user will use this distribution.

# I don't wanna read, tell me what to do to get it ! 
- Open a terminal 
- Type : `sudo wget -O - https://raw.githubusercontent.com/rebrec/raiwallet_installer/master/install.sh | sudo bash`
- If prompted, type your user password
- Wait until the installion is done.
- Enjoy.


## How does it work ?

The script will :
- Install docker.io if not already installed
- Allow your user to run it without being root
- Add extra autorizations so that docker container can run the wallet on your X server
- Download my prebuild docker image containing the rai_wallet (if you want to build your own, you can get my Dockerfile from its dedicated [repository](https://github.com/rebrec/raiwallet_docker_container))
- Create a shortcut that will run the wallet within the container.


## How to install ?

Simple as typing into a terminal : 

``` bash
sudo wget -O - https://raw.githubusercontent.com/rebrec/raiwallet_installer/master/install.sh | sudo bash
```
You will be asked to type your user password so that the installer can do its stuff.



## How to Use my freshly installed wallet ?

Just search for "Raiblocks Wallet" on your application menu.

Data to backup is stored into the RaiBlocks folder of your HOME directory.


## Potential improvements

Depending on the feedback from users, here is what i could do to improve this project :

- Make it work on other Linux distributions
- Make distribution packages (more fast and easy to install and UPDATE
  - For Ubuntu
  - For Other distributions.
- Other suggestions ?


## Feedback / Issues

Feel free to open an issue [here](https://github.com/rebrec/raiwallet_installer/issues) if things are not working as expected for you, etc.


## Donation

My donation address is here : xrb_13dooo43obdz44fock4yh76gfs5w6uyfyodqmkm33tf6ou5uumafmjoohj1o

