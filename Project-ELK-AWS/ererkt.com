server {
    listen 80;
    server_name elk.ererkt.com;
    location / {
        proxy_pass http://localhost:5601;
    }
}