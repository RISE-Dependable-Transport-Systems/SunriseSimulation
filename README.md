The following two scripts help install all the programs required to get the simulation working. Mavlink is not installed by default, so before running the install script run the following commands is Mavlink isn't installed by default:


```sh
wget https://github.com/mavlink/MAVSDK/releases/download/v2.0.0/libmavsdk-dev_2.0.0_ubuntu22.04_amd64.deb
sudo dpkg -i libmavsdk-dev*.deb

```


Apart from this, Carla is not installed by default download the [tar file](https://risecloud.sharepoint.com/:u:/r/sites/31c3dedd53324aadaf4e5fc493ad5e0f/Delade%20dokument/General/RISE%20SubUC%204.1/Simulations/CARLA_0.9.15-237-gd6f23ed84-dirty.tar.gz?csf=1&web=1&e=8js4qh) into the Carla folder and extract it there. 

I also assume that ROS2 is installed on the system correctly and the correct files are sourced according to [the ROS installation steps.](https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html#install-ros-2-packages) Futhermore, I these scripts are written for ZSH so you might need to tweak a thing here and there if you use bash. 

To run the complete setup use the setup.sh script which should start all the required systems to get the truck to work. 
