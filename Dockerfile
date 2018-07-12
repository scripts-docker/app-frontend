FROM 172.30.1.1:5000/ci/nginx-base

ADD http://nexus-ci.127.0.0.1.nip.io/repository/npm-privado/angular-example/-/angular-example-6.0.0.tgz ${APP_ROOT}

RUN mkdir dist && \
    tar -xvzf angular-example-6.0.0.tgz -C dist && \
    mv dist/package/* /usr/share/nginx/html

RUN ls -lha /usr/share/nginx/html

RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd && \
    chgrp -R 0 /etc/nginx/ && \
    chmod -R g=u /etc/nginx/ && \
    chgrp -R 0 /var/log/nginx/ && \
    chmod -R g=u /var/log/nginx/ && \
    chgrp -R 0 /var/cache/nginx/ && \
    chmod -R g=u /var/cache/nginx/ && \
    chgrp -R 0 /var/run/ && \
    chmod -R g=u /var/run/

USER 10001

ENTRYPOINT [ "uid_entrypoint" ]

CMD ["nginx", "-g", "daemon off;"]