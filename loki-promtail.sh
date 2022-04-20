#!/bin/bash
cd $HOME


sudo mkdir /etc/loki

sudo apt install wget unzip -y
wget https://github.com/grafana/loki/releases/download/v2.5.0/loki-linux-amd64.zip && wget https://github.com/grafana/loki/releases/download/v2.5.0/promtail-linux-amd64.zip

wget https://raw.githubusercontent.com/grafana/loki/master/cmd/loki/loki-local-config.yaml && wget https://raw.githubusercontent.com/grafana/loki/main/clients/cmd/promtail/promtail-local-config.yaml

unzip loki-linux-amd64.zip && unzip promtail-linux-amd64.zip

rm loki-linux-amd64.zip unzip promtail-linux-amd64.zip

chmod a+x loki-linux-amd64 promtail-linux-amd64

sudo mv promtail-linux-amd64 loki-linux-amd64 -t /usr/bin/

sudo mv promtail-local-config.yaml loki-local-config.yaml -t /etc/loki/

sudo useradd --system loki && sudo useradd --system promtail

sudo usermod -a -G adm promtail


sudo tee <<EOF >/dev/null /etc/systemd/system/loki.service
[Unit]
Description=Loki service 
After=network.target 

[Service]
Type=simple
User=loki
ExecStart=/usr/bin/loki-linux-amd64 -config.file /etc/loki/loki-local-config.yaml

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable loki.service

sudo systemctl start loki.service


sudo tee <<EOF >/dev/null /etc/systemd/system/promtail.service
[Unit]
Description=Promtail service
After=network.target

[Service]
Type=simple
User=promtail
ExecStart=/usr/bin/promtail-linux-amd64 -config.file /etc/loki/promtail-local-config.yaml

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable promtail.service && sudo systemctl start promtail.service

echo "Loki+Promtail installed"
echo "Status:"
sudo systemctl status promtail.service
sudo systemctl status loki.service
