# --- Go Application Build and Zip Process ---

# Local-exec provisioner to build the Go binary before zipping.
# This runs 'go build' on the machine where Terraform is executed.
resource "null_resource" "build_go_binary" {
  # Triggers a rebuild when the Go source file changes.
  # Adjust the path to your main Go entry point if it's not 'backend/cmd/api/main.go'.
  triggers = {
    go_source_hash = filemd5("${path.root}/../backend/cmd/lambda/main.go")
  }

  provisioner "local-exec" {
    # Command to build the Go executable for AWS Lambda.
    # It sets GOOS=linux and GOARCH=amd64 for Lambda compatibility,
    # and CGO_ENABLED=0 for static linking.
    # The output 'bootstrap' is the default handler name for 'provided.al2' runtime.
    command = <<EOT
      mkdir -p ${path.root}/../backend/build 
      CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${path.root}/../backend/build/bootstrap ${path.root}/../backend/cmd/lambda/
    EOT
    # working_dir is set to backend directory.
    working_dir = "${path.root}/../backend"
  }

  # Ensure this build step runs before any Lambda-related resources that depend on the binary.
  # It should depend on the IAM role creation to ensure permissions are set up if needed for build-time operations
  # (though usually not for a simple Go build).
  depends_on = [
    aws_iam_role.lambda_execution_role,
  ]
}

# Data source to package the compiled Go binary into a zip file for Lambda.
# This 'archive_file' automatically creates the zip based on the 'bootstrap' binary.
data "archive_file" "lambda_zip" {
  type = "zip"
  # Source the 'bootstrap' executable created by the 'null_resource'.
  # Path is relative to where Terraform is running (path.root, which is 'terraform/').
  source_file = "${path.root}/../backend/build/bootstrap"
  # Define the output path for the zip file.
  output_path = "${path.root}/../backend/build/backend.zip"

  # Ensure the Go binary is built before attempting to zip it.
  depends_on = [
    null_resource.build_go_binary,
  ]
}

