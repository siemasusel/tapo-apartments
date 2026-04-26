Bootstrap this stack first to create the S3 bucket and DynamoDB table used by the
root Terraform remote backend.

Example:

```bash
cd terraform/bootstrap
terraform init
terraform apply
```

Then copy `../backend.hcl.example` to a local backend config file and update the
bucket name if needed:

```bash
cd ../
cp backend.hcl.example backend.hcl
terraform init -migrate-state -backend-config=backend.hcl
```
