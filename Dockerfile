FROM 172.30.1.1:5000/ci/nginx-base

ARG URL_ARTEFATO_DOWNLOAD

ARG ARTEFATO

ADD $URL_ARTEFATO_DOWNLOAD $APP_ROOT

RUN mkdir dist && \
    tar -xvzf $ARTEFATO -C dist && \
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
    chmod -R g=u /var/run/ && \
    chgrp -R 0 /usr/share/nginx/ && \
    chmod -R g=u /usr/share/nginx/

USER 10001

ENTRYPOINT [ "uid_entrypoint" ]

CMD ["nginx", "-g", "daemon off;"]