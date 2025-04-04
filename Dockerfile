FROM python:3.9-slim AS build

WORKDIR /app

COPY . /app  

RUN pip install --no-cache-dir -r requirements.txt  

FROM nginx:alpine

WORKDIR /app

RUN apk add --no-cache python3 py3-pip

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app /app

RUN pip3 install --no-cache-dir -r /app/requirements.txt

EXPOSE 80

CMD ["python3", "app.py"]
