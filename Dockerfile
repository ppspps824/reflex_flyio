FROM ubuntu:22.04

# Install dependencies
RUN apt-get update
RUN apt-get install --yes build-essential curl nginx supervisor unzip
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash -
RUN apt-get install --yes build-essential python3 python3-pip nodejs
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# Set the main working directory
WORKDIR /app

# Copy all the source code to the main working directory
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt
RUN reflex init

CMD ["/usr/bin/supervisord", "-c", "/app/supervisor.conf"]

EXPOSE 80