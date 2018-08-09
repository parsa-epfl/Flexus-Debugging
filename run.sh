sudo docker run --publish=7474:7474 --publish=7687:7687 --volume=$HOME/docker_test/data:/data --volume=$HOME/docker_test/logs:/logs test:0.1
