cd /home/azureuser/services/engine_main
mkdir -p logs/ res/
#docker login onecliq.azurecr.io --username onecliq --password ...
docker compose pull
docker compose up -d
docker image prune -af 2>/dev/null
