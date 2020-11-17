server {
        listen 80;
        server_name EC2_서버의_PUBLIC_IP;

        location = /favicon.ico { access_log off; log_not_found off; }

        location /static {
                alias /home/ubuntu/env/works5-deploy/static_files;
        }

        location /media {
                alias /home/ubuntu/env/works5-deploy/media;
        }

        location / {
                include proxy_params;
                proxy_pass http://unix:/tmp/gunicorn.sock;
        }
}