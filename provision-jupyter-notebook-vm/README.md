# Provision Jupyter Notebook with VM


1. Generate service-account token
```
https://console.cloud.google.com/apis/credentials/serviceaccountkey

```

2. Open shell to install terraform
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

3. Edit variables project_id & validate, apply

```bash
terraform init
terraform validate
terraform apply
```


## Reference
https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-build
https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform