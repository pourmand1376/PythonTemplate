cd /home/azureuser/services/cliqmate-main
mkdir -p logs/ res/
#docker login sample.azurecr.io --username onecliq --password ...
docker compose pull
docker compose up -d
