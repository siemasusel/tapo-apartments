# --- Go Application Build and Zip Process ---

# Data source to package the compiled Go binary into a zip file for Lambda.
# This 'archive_file' automatically creates the zip based on the 'bootstrap' binary.
data "archive_file" "lambda_zip" {
  type = "zip"
  # Source the 'bootstrap' executable created by the 'null_resource'.
  # Path is relative to where Terraform is running (path.root, which is 'terraform/').
  source_file = "${path.root}/../backend/.build/bootstrap"
  # Define the output path for the zip file.
  output_path = "${path.root}/../backend/.build/backend.zip"
}

