FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .

# RUN pip config --user set global.index-url  https://${REGISTRY_USER}:${REGISTRY_PASS}@repo.mofid.dev/artifactory/api/pypi/pypi-remote/simple

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["main.py"]
