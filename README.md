# STEPS
You dont have to use sudo if opened as sudo or your user is added to group
1. clone ardupilot repo with submodels 
2. build docker - sudo compose build
3. run - docker compose up -d  
4. open bash - docker exec -it ros1_noetic bash | docker exec -it ros2_humble bash
5. build workspace 

# IN CASE OF NEW BUILD
Make sure all containers are turned off 

    docker compose down 