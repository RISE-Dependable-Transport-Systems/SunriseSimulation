sudo apt update && sudo apt install -y tmux qtcreator qtbase5-dev libqt5serialport5-dev qtmultimedia5-dev libqt5gamepad5-dev libunwind-dev libqt5serialport5-dev git build-essential cmake python3-colcon-common-extensions
mkdir ../Sunrise
cp ./setup.sh ../Sunrise/
cp *.patch ../Sunrise/
cd ../Sunrise

mkdir carla
cd carla
# wget carla/.tar
# tar -xvf carla/0.9..
cd ..

# carla-ros-bridge
#
mkdir -p carla-ros-bridge/src
cd carla-ros-bridge/src
git clone --recurse-submodules git@github.com:RISE-Dependable-Transport-Systems/carla-ros-bridge.git
cd ../
rosdep install -i --from-path src --rosdistro humble -r -y
pip3 install -r src/carla-ros-bridge/requirements.txt
colcon build --symlink-install --packages-skip rviz_carla_plugin carla_ad_demo pcl_recorder
source ./install/setup.zsh
cd ..
# waywiser
#

#wget https://github.com/mavlink/MAVSDK/releases/download/v2.0.0/libmavsdk-dev_2.0.0_ubuntu22.04_amd64.deb
#sudo dpkg -i libmavsdk-dev*.deb

mkdir -p waywiser/src
cd waywiser/src
git clone --recurse-submodules git@github.com:RISE-Dependable-Transport-Systems/WayWiseR.git
cd ..
rosdep install -i --from-path src --rosdistro humble -r -y
colcon build --symlink-install

# control tower
#
#
cd ..
git clone --recursive git@github.com:RISE-Dependable-Transport-Systems/ControlTower.git
cd ControlTower
mv ../*.patch ./
git apply *.patch
mkdir build && cd build
cmake ..
cmake --build . --parallel
cd ..
cd ..
