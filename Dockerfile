FROM redis:4.0.14-alpine3.10

RUN apk update && apk add --upgrade bzip2 && apk add bash

WORKDIR /init

COPY . .

HEALTHCHECK --start-period=3600s --timeout=3s --retries=1 CMD ["bash", "/init/healthcheck.sh"]

ENTRYPOINT ["bash", "/init/entrypoint.sh"]

EXPOSE 6379
