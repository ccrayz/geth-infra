## Geth Testing Infra

I personally use Terraform to provide a simple infrastructure configuration for running and testing Geth.

### Create an s3 and dynamo DB table to manage the state.

```
cd terraform/init
terraform apply
```

### Generate an SSH key to access the instance

```
./gen_ssh_key.sh
```

### Create all the resources to run the Geth.

```
cd terraform/geth
terraform apply
```
