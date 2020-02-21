FROM python:3.6-alpine
RUN apk update --no-cache
RUN apk add --no-cache ca-certificates libffi libvirt libzmq openssh-client openssl tzdata
RUN apk add --no-cache g++ gcc libffi-dev libvirt-dev musl-dev openssl-dev zeromq-dev
RUN pip wheel -w /wheels virtualbmc

FROM python:3.6-alpine
COPY --from=0 /wheels /wheels
COPY vbmc-init.sh /
COPY setup.sh /
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh /vbmc-init.sh
RUN sh /setup.sh

CMD /entrypoint.sh

