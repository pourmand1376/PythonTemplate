cd folder_path
docker compose down
sudo tar -cvf volumes-$(date +"%Y%m%d_%H%M%S").tgz volumes
docker compose up -d

# sudo tar xf volumes-adsasd.tgz