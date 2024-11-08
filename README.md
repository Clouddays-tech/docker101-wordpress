# Docker101-wordpress
Run your wordpress TLS letencrypt site in 5mins 

## Creating Cloud VM with Public IP Address 

## Create A record for your webpage in your public dns server. 
Grab the VM public IP and create A record.

## SSH into your VM


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

Once the script is completed check it out `docker ps` and browse url in the browser.

![Screenshot](images/webportal.jpg)

![Screenshot2](images/webportal2.jpg)

