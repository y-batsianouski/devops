FROM nginx
RUN mkdir -p /etc/nginx/ssl /etc/nginx/conf.d
COPY ./assets/ssl/dhparam.pem /etc/nginx/ssl/dhparam.pem
COPY ./assets/ssl/nomad.local.key /etc/nginx/ssl/nomad.local.key
COPY ./assets/ssl/nomad.local.crt /etc/nginx/ssl/nomad.local.crt
COPY ./assets/conf.d/nomad.local.conf /etc/nginx/conf.d/nomad.local.conf