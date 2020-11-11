# Mister Auto / FTP Inspec Profile

This repository holds the Mister Auto FTP [Inspec](https://www.inspec.io/) Profile.

## Usage

Load credentials and launch tests :

$ . ./skale-5.sh prod
$ make inspec-test SERVICE=infrastructure/ftp ENV=prod

### Profile Attributes

* **gcp_project_id** - (Default: "", type: string) - The target GCP Project that must be specified.
* **customer** - (Default: '', type: string) - The customer name
* **region** - (Default: "", type: string) - GCP region
* **env** - (Default: '', type: string) - The environment name (preprod, prod)
