#!/bin/zsh
# Check if tmux is installed
if ! command -v tmux &>/dev/null; then
  echo "tmux is not installed. Install it first."
  sudo apt install -y tmux
fi
# Define the tmux session name
SESSION_NAME="carla_sunrise"

# Check if the session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
  # Create a new tmux session
  #
  export MAIN_FOLDER=$PWD
  export CARLA_ROOT=$MAIN_FOLDER/carla
  export PYTHONPATH=$PYTHONPATH:$CARLA_ROOT/PythonAPI/carla/dist/carla-0.9.15-py3.10-linux-x86_64.egg:$CARLA_ROOT/PythonAPI/carla


  # Complile both and source 
  #

  cd $MAIN_FOLDER/carla-ros-bridge/
  colcon build --symlink-install --packages-skip rviz_carla_plugin carla_ad_demo pcl_recorder
  source install/setup.zsh
  cd $MAIN_FOLDER/waywiser
  colcon build
  source install/setup.zsh

  cd $MAIN_FOLDER
  tmux new -d -s $SESSION_NAME


  tmux send-keys -t $SESSION_NAME "$CARLA_ROOT/CarlaUE4.sh -carla-streaming-port=0" C-m
  sleep 5

  tmux new-window -t $SESSION_NAME
  

  tmux send-keys -t $SESSION_NAME "ros2 launch waywiser_carla carla.launch.py" C-m
  tmux split-window -v -t $SESSION_NAME
  sleep 5

  tmux send-keys -t $SESSION_NAME "ros2 launch waywiser_carla waywiser_carla_relay.launch.py" C-m
  tmux split-window -h -t $SESSION_NAME

  tmux send-keys -t $SESSION_NAME "ros2 launch waywiser_hwbringup waywise_truck_autopilot.launch.py" C-m
  sleep 5

  tmux select-pane -t 1
  tmux split-window -h -t $SESSION_NAME
  tmux send-keys -t $SESSION_NAME "ros2 launch waywiser_carla carla_osm_tile_server.launch.py" C-m
  
  tmux split-window -v -t $SESSION_NAME
  tmux send-keys -t $SESSION_NAME "$MAIN_FOLDER/ControlTower/build/ControlTower" C-m


  tmux new-window -t $SESSION_NAME
  tmux send-keys -t $SESSION_NAME "ros2 launch waywiser_twist_safety twist_safety.launch.py use_sim_time:=true" C-m

  tmux split-window -h -t $SESSION_NAME
  tmux send-keys -t $SESSION_NAME "ros2 topic pub --once /emergency_stop/target_state waywiser_twist_safety/msg/EmergencyStopState \"{sender_id : 'command_line' , state : 1}\"" C-m
  tmux attach-session -t carla_sunrise 

else
  echo "Tmux already running. Kill tmux: \"tmux kill-server\""
fi
