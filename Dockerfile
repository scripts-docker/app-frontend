FROM 172.30.1.1:5000/ci/nginx-base

## copy over the artifacts in dist folder to default nginx public folder
ADD https://github.com/scripts-docker/app-frontend/blob/master/app-frontend.tar.gz?raw=true ${APP_ROOT}

RUN mkdir dist && \
    tar -xvzf app-frontend.tar.gz -C dist/

COPY dist/ /usr/share/nginx/html

RUN chgrp -R 0 /usr/share/nginx/ && \
    chmod -R g=u /usr/share/nginx/

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "uid_entrypoint" ]