FROM nginx:alpine

WORKDIR /app

COPY requirements.txt .

RUN apk add --no-cache python3 py3-pip && \
    python3 -m venv /venv && \
    /venv/bin/pip install --no-cache-dir -r requirements.txt && \
    /venv/bin/pip install gunicorn

COPY . /app

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["/venv/bin/gunicorn", "-b", "0.0.0.0:80", "app:app"]
