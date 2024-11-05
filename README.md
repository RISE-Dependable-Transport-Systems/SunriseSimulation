The following two scripts help install all the programs required to get the simulation for SUNRISE working.

Mavlink is not installed by default, so before running the install script run the following command as Mavlink-2.0 isn't installed by default:
It might be that you need the correct version of mavlink depending upon the OS version. 

```sh
wget https://github.com/mavlink/MAVSDK/releases/download/v2.0.0/libmavsdk-dev_2.0.0_ubuntu22.04_amd64.deb
sudo dpkg -i libmavsdk-dev*.deb

```


I also assume that ROS2 is installed on the system correctly and the correct files are sourced according to [the ROS installation steps.](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html#install-ros-2-packages) Futhermore, these scripts are written for ZSH so you might need to tweak a thing here and there if you use bash. 


To run the complete setup use the setup.sh script which should start all the required systems to get the truck to work. 
