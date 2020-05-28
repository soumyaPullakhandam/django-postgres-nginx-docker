FROM python:3.8.0-alpine

WORKDIR '/app'

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
RUN pip install --upgrade pip
COPY ./requirement.txt ./requirement.txt
RUN pip install -r requirement.txt

COPY . .

FROM nginx

EXPOSE 80
COPY --from=0 /app /usr/share/nginx/html

