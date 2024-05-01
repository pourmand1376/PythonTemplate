cd docker
rsync --recursive cliqmate-dev/ cliqmate:/home/azureuser/services/cliqmate-dev/
rsync --recursive cliqmate-main/ cliqmate:/home/azureuser/services/cliqmate-main/
rsync --recursive cliqmate-staging/ cliqmate:/home/azureuser/services/cliqmate-staging/
rsync --recursive traefik/ cliqmate:/home/azureuser/services/traefik/
