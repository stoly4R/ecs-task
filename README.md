# ecs homework

Following code provides to ability to create a simple ecs cluster with nginx and prometheus dockers.<br>
To deply the environment please use deploy.sh script:<br>
```
   ./deploy.sh --deploy: to create an environment 
   ./deploy.sh --remove: to delete an environment
```
## Changelog
Dont forget to update changelog box upon changes.<br>
```
06.09.2021
*   Changed terraform binary from zip to tar.gz
    Added a deploy.sh file
    Remove tsstate and tfstate.backup
```
## TODO
```
Only 08,443,22 should be opened.
Redirect all traffic from 80 to 444.
Create SSL certificates.
Add the following headers to nginx.conf:
   add_header X-Frame-Options "SAMEORIGIN";
   add_header Strict-Transport-Security "max-age=31536000; includeSubdomains; preload";
   add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;
   add_header X-XSS-Protection "1; mode=block";
   ssl_protocols TLSv1.2 TLSv1.3;
```
