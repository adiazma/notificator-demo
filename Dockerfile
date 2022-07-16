ARG UNAME=docker

FROM python:3.9

ADD requirements.txt /code/

RUN pip install --no-cache-dir -r /code/requirements.txt

ADD . /code/

RUN chown -R $UNAME:$UNAME /code/

USER $UNAME

WORKDIR /code
