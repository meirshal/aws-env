# aws-env
A (somewhat) opinionated but simple tool for fetching configuration and secrets and injecting them as environment variables.
Supports managing secrets in AWS Secrets Manager and storing non-secret configuration in AWS S3.

## Setup
### Prerequisits
#### Storing secrets
Secrets should be stored in AWS Secret Manager, with the following convention: `{service name}-{environment}`, for instance: `server-staging`.
#### Storing non-secret configuration
Create an S3 bucket to store configuration files in. 
There should be directory per service, containing one file per environment. For instance, we could have the following structure:
```
.
├── web-server
│   ├── staging.yml
│   └── production.yml
├── service-a
│   ├── staging.yml
│   └── production.yml
├── service-b
│   ├── staging.yml
│   └── production.yml
```
The files should be in .yaml format, with all environment variables stored under the "environment" key. Example: 
```
environment:
    NODE_ENV: production
    TZ: UTC
```

### Installing aws-env 
1. Make sure that you have python installed
2. Run `pip install pyyaml`
3. Install bpkg if not already installed by running `curl -Lo- "https://raw.githubusercontent.com/bpkg/bpkg/master/setup.sh" | bash`
4. Install aws-env: `sudo bpkg install meirshal/aws-env`


## Usage
`$ eval $(aws-env -e <environment> -s <service name> -b <S3 base path>) && your_process_here`
