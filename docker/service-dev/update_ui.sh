cd /home/azureuser/services/engine_dev
mkdir -p logs/ res/
#docker login onecliq.azurecr.io --username onecliq --password ...
docker compose pull ui
docker compose up -d ui
docker image prune -af 2>/dev/null
docker builder prune -af 2>/dev/null
