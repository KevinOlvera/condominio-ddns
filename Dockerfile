FROM alpine:3.19.1

RUN apk add --no-cache bash curl bind-tools git

RUN git clone https://github.com/dondominio/dondns-bash.git /app

COPY . /app

RUN chmod +x /app/run.sh
RUN chmod +x /app/entrypoint.sh
RUN chmod +x /app/dondominio/dondomcli.sh

ENTRYPOINT ["/app/entrypoint.sh"]
