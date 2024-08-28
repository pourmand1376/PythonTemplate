cd /home/azureuser/services/engine_dev
mkdir -p logs/ res/
#docker login onecliq.azurecr.io --username onecliq --password ...
docker compose pull queue
docker compose up -d queue
docker image prune -af 2>/dev/null
docker builder prune -af 2>/dev/null
