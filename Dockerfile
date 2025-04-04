FROM python:3.9-slim AS build


WORKDIR /app  # This makes `/app` the working directory


COPY requirements.txt .


RUN pip install --no-cache-dir -r requirements.txt  

COPY . /app  

FROM nginx:alpine

WORKDIR /app

RUN apk add --no-cache python3 py3-pip

COPY nginx.conf /etc/nginx/nginx.conf


COPY --from=build /app /app

EXPOSE 80


CMD ["python3", "app.py"]
