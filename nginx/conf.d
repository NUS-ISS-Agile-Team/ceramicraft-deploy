server {
    listen 80;
    server_name _;

    # HTTP 路径分流
    location /api/user/ {
        proxy_pass http://msuser.local:3000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /web/mer/ {
        proxy_pass http://femer.local:4173/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /web/cus/ {
        proxy_pass http://fecus.local:4173/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # 其他路径
    location / {
        proxy_pass http://127.0.0.1:5000/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
