FROM python:3.9 AS build

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

FROM nginx:alpine

WORKDIR /app

RUN apk add --no-cache python3 py3-pip && \
    python3 -m venv /venv && \
    /venv/bin/pip install --no-cache-dir -r /app/requirements.txt && \
    /venv/bin/pip install gunicorn

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app /app

EXPOSE 80

CMD ["/venv/bin/gunicorn", "-b", "0.0.0.0:80", "app:app"]
