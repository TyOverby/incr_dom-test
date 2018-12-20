docker build -t server ./
docker run -p 9000:9000 --mount type=bind,source="$(pwd)"/src,target=/root/src server 

