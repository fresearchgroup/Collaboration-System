FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
RUN apt-get install libmysqlclient-dev
ADD . /code/
RUN cp temp/patch_for_reversion_compare.py /usr/local/lib/python3.6/site-packages/reversion_compare/views.py
RUN cp temp/board_base.html /usr/local/lib/python3.6/site-packages/machina/templates/machina/board_base.html
RUN cp .env.docker .env
