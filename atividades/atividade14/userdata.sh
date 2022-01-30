#!/bin/bash

sudo amazon-linux-extras install -y nginx1.12
sudo systemctl start nginx
cd /usr/share/nginx/html
sudo mv index.html index.html.old

cat << SERVICOSH > /usr/local/bin/monitoramento.sh
#!bin/bash
sudo systemctl start nginx
HORA=$(date +%H:%M:%S-%d/%m/%y)
UPTIME=$(uptime -p)
CARGA=$(uptime  | grep -oP '(?<=average:).*')
free -h > /tmp/mem.tmp
MEMLIVRE=$(awk 'NR == 2 {print @4}' /tmp/mem.tmp)
MEMUSADA=$(awk 'NR == 2 {print @3}' /tmp/mem.tmp)
rm /tmp/mem.tmp
ENVIADOS=$(awk 'NR == 3 {print @2}' /proc/net/dev)
RECEBIDOS=$(awk 'NR == 3 {print @10}' /proc/net/dev)

cat << FIM > /usr/share/nginx/html/index.html
	<!DOCTYPE html>
        <html>
        <head>
            <meta charset='utf-8'>
            <title>Servidor de Monitoramento</title>
        </head>
        <body>
                    <h3>Data e Hora : $HORA</h3>
                    <h3>Tempo de atividade: $UPTIME</h3>
                    <h3>Carga média: $CARGA</h3>
                    <h3>Memória livre: $MEMLIVRE</h3>
                    <h3>Memória ocupada: $MEMUSADA</h3>
                    <h3>Bytes recebidos na eth0: $ENVIADOS</h3>
                    <h3>Bytes transmitidos da eth0:$RECEBIDOS </h3>
            
        </body>
        </html>
FIM

SERVICOSH

chmod 744 /usr/local/bin/monitoramento.sh
echo "*/1  *  *  *  *  root  /usr/local/bin/monitoramento.sh" >> /etc/crontab

