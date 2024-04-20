#! /usr/bin/env bash
# Yeah everything about this is probably super insecure and messed up. But I don't know the proper ways to do any of this instead

working_dir="/home/$USER/.config/openvpn/client"
echo "$working_dir"
gateways_json=$working_dir/gateways.json
ca_cert_file=$working_dir/vpn-ca.pem
cert_file=$working_dir/cert.pem
key_file=$working_dir/key.pem
ovpn_file=$working_dir/riseup.conf

mkdir -p "$working_dir"
chmod 777 "$working_dir"

# SETTINGS
port=53
server="vpn09-mia.riseup.net"
proto="tcp"

update_gateways() {
  curl https://api.black.riseup.net/3/config/eip-service.json -o"$gateways_json"
}

update_vpn_ca_certificate() {
  curl https://black.riseup.net/ca.crt -o"$ca_cert_file"
}

update_vpn_client_credentials() {
  returned_data=$(curl https://api.black.riseup.net/3/cert)
  key=$(echo "$returned_data" | awk '/BEGIN RSA PRIVATE KEY/,/END RSA PRIVATE KEY/')
  cert=$(echo "$returned_data" | awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/')
  echo "$key" >"$key_file"
  echo "$cert" >"$cert_file"
}

generate_configuration() {
  server_info=$(jq ".gateways[] | select(.host == \"$server\")" "$gateways_json")
  ip_address=$(echo "$server_info" | jq .ip_address | tr -d \")
  host=$(echo "$server_info" | jq .host | tr -d \")
  location=$(echo "$server_info" | jq .location | tr -d \")

  cat <<EOF >"$ovpn_file"
client
dev tun

remote $ip_address $port # $host in $location
proto $proto
verify-x509-name $(echo "$host" | cut -d '.' -f 1) name

cipher AES-256-GCM
tls-version-min 1.3

resolv-retry infinite
keepalive 10 60
nobind
verb 3

remote-cert-tls server
remote-cert-eku "TLS Web Server Authentication"

# BEGIN EXCLUDE ROUTES
route 8.8.8.8 255.255.255.255 net_gateway
route 192.168.123.0 255.255.255.0 net_gateway
route 170.114.52.3 255.255.255.255 net_gateway
# END EXCLUDE ROUTES

ca $(realpath "$ca_cert_file")
cert $(realpath "$cert_file")
key $(realpath "$key_file")
EOF

}

update_gateways
update_vpn_ca_certificate
update_vpn_client_credentials
generate_configuration

chmod -R 777 "$working_dir"
