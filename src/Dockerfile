# base image
FROM python:3.12-slim-bookworm

# set environment variable
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# set work directory
WORKDIR /src

# update pip
RUN pip install --upgrade pip

# copy and install packages from requirements.txt
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# run entrypoint.sh
ENTRYPOINT ["sh", "/src/entrypoint.sh"]