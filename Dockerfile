FROM nginx:alpine

WORKDIR /app

COPY requirements.txt .

RUN apk add --no-cache python3 py3-pip && \
    /usr/bin/pip3 install --no-cache-dir -r requirements.txt && \
    /usr/bin/pip3 install gunicorn

COPY . /app

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["gunicorn", "-b", "0.0.0.0:80", "app:app"]

