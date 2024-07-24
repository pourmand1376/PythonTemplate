# 

https://stackoverflow.com/questions/24718706/backup-restore-a-dockerized-postgresql-database

```
docker compose exec db pg_dumpall -c -U postgres | gzip > dump_`date +%Y-%m-%d"_"%H_%M_%S`.sql.gz
```