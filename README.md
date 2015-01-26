# Docker image with Nginx 
This image is build using Ubuntu 14.04 with Nginx.

Includes:

- nginx

Important:

- Logs are at /var/log/supervisor so you can map that directory
- Application root directory is /var/www so make sure you map the application there
- Nginx configuration was provided by https://github.com/perusio/drupal-with-nginx but it's modified

## To build

    $ make build

    or

    $ docker build -t yourname/nginx-drupal .


## To run
Nginx will look for files in /var/www so you need to map your application to that directory.

    $ docker run -d -p 8000:80 -v application:/var/www yourname/nginx

## Fig

    web:
      image: iiiepe/nginx
      volumes:
        - application:/var/www
        - logs:/var/log/supervisor
      ports:
        - "80:80"

         
### License
Released under the MIT License.
