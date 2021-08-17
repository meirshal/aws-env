# aws-env
A (somewhat) opinionated but simple tool for fetching configuration and secrets and injecting them as environment variables.
Supports managing secrets in AWS Secrets Manager and storing non-secret configuration in AWS S3.

## Usage
Run `eval $(secrets.sh -s [secret_name])`
