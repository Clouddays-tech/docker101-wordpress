# Docker101-wordpress
Run your wordpress TLS letencrypt site in 5mins 

## Creating Cloud VM with Public IP Address 
If you dont have a VM with public IP, here is the command to create on Azure IAAS VM with public IP. Create anywhere in any places with cmd, GUI or IAC. 
But Ensure port 22, 80 and 443 are allowed inbound direction.
```
az group create -n RG001 -l westus

# Create VM
az vm create \
  --resource-group RG001 --name wordpress_vm \
  --image Ubuntu2204 --size Standard_B2s \
  --admin-username azureuser --admin-password P@ssw0rd1234567 \
  --public-ip-sku Standard --authentication-type password  

# To install docker runtime and docker compose.
az vm extension set \
  --resource-group RG001 \
  --vm-name wordpress_vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --settings '{"fileUris": ["https://raw.githubusercontent.com/Clouddays-tech/docker101-wordpress/refs/heads/main/cloudinit.sh"], "commandToExecute": "./cloudinit.sh"}'

# Open port 22 for SSH
az network nsg rule create \
  --resource-group RG001 \
  --nsg-name wordpress_vmNSG \
  --name Allow-SSH \
  --priority 1001 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 22
# Open port 80 for HTTP
az network nsg rule create \
  --resource-group RG001 \
  --nsg-name wordpress_vmNSG \
  --name Allow-HTTP \
  --priority 1002 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 80
# Open port 443 for HTTPS
az network nsg rule create \
  --resource-group RG001 \
  --nsg-name wordpress_vmNSG \
  --name Allow-HTTPS \
  --priority 1003 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --destination-port-range 443

# Show Public IP
az vm show \
  --resource-group RG001 --name wordpress_vm \
  --show-details --query "publicIps" \
  --output tsv
```

## Create A record for your webpage in your public dns server. 

Grab the VM public IP and create public DNS A record.

## SSH into your VM
ssh azureuser@yourIPAddress

## Configuraiton 

```
# Create directory
mkdir wordpress

# Clone Git Repo
git clone https://github.com/Clouddays-tech/docker101-wordpress.git

# CD into directory
cd docker101-wordpress/

# Run Script
sudo bash init-letencrypt.sh
```
Fill in the SQL USER and SQL Password and your domain name (FQDN) for certificate request.

![terminal](images/info.jpg)

The TLS certificate is successfully generated from letsencrypt.

![certificate](images/certificate.jpg)


Once the script processing is completed check it out running containers `docker ps` and BOOM! your webpage is UP and Running. 

![Screenshot](images/webportal.jpg)

![Screenshot2](images/webportal2.jpg)

