# Modlishka Terraform Module

Used for deploying Modlishka into AWS.

Includes:

- Server
- DNS configuration
- Security groups

## Example Module Usage

```text
# main.tf
provider "aws" {
  profile = "default"
  region = "ap-southeast-2"
}

module "modlishka" {
  source = "github.com/danielmoore-info/terraform-modules//aws/services/modlishka"
  instance_type = "t2.micro"
  name = "modlishka"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCGj4O5EQpgIW7zokhs510dx1l1JaTikaw+K0RhcxgLWA1TU4XqFZPckTWpyFU0XTgmg/a8aeTwFCQ6gfgS8Al9edsJcQtva9voGAyl6QWGNbpFqkgGDTiB+6wed"
  domain = "example.com"
}

output "key_id" {
  value = module.modlishka.key_id
}

output "key_secret" {
  value = module.modlishka.key_secret
}
```

## Command Line Example

```bash
[] ~/Documents/terraform-live/services/modlishka <master> ✗ terraform apply
module.modlishka.module.dns.data.aws_route53_zone.zone: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

Plan: 9 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.modlishka.aws_default_vpc.default: Creating...
module.modlishka.module.iam.aws_iam_user.r53user: Creating...
module.modlishka.module.server.aws_key_pair.ec2key: Creating...
module.modlishka.module.dns.aws_route53_record.dns_CNAME_record: Creating...
module.modlishka.module.server.aws_key_pair.ec2key: Creation complete after 0s [id=terraform-20200121005752855900000001]
module.modlishka.aws_default_vpc.default: Creation complete after 1s [id=vpc-68d0850f]
module.modlishka.module.sg.aws_security_group.webserversg: Creating...
module.modlishka.module.iam.aws_iam_user.r53user: Creation complete after 2s [id=r53user]
module.modlishka.module.iam.aws_iam_user_policy.r53_ro: Creating...
module.modlishka.module.iam.aws_iam_access_key.r53userkey: Creating...
module.modlishka.module.sg.aws_security_group.webserversg: Creation complete after 1s [id=sg-07a40199f4d8182ac]
module.modlishka.module.server.aws_instance.ec2instance: Creating...
module.modlishka.module.iam.aws_iam_access_key.r53userkey: Creation complete after 1s [id=AKIA4BFCIV2V7NPFLJUQ]
module.modlishka.module.iam.aws_iam_user_policy.r53_ro: Creation complete after 1s [id=r53user:r53ro]
module.modlishka.module.dns.aws_route53_record.dns_CNAME_record: Still creating... [10s elapsed]
module.modlishka.module.server.aws_instance.ec2instance: Still creating... [10s elapsed]

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

Outputs:

key_id = AKIA4BFCaaaaaaaa
key_secret = FBAMBzGK9BlytvWaaaaaaaaaaaaaa
[] ~/Documents/terraform-live/services/modlishka <master> ✗ ansible-playbook --private-key ~/.ssh/aws-ec2-keypair.pem -e "domain=example.com email=support@example.com key_id=AKIA4BFCaaaaaaa key_secret=FBAMBzGK9Blytvaaaaaaaaaaa" .terraform/modules/modlishka/aws/services/modlishka/config/ansible-playbook.yml

PLAY [web*] *******************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
The authenticity of host 'web.example.com (13.55.115.162)' can't be established.
ECDSA key fingerprint is SHA256:5HSzj5chHhcgvSHW8k5wAB6Tzt8w73eOEk0D5u2o/2E.
Are you sure you want to continue connecting (yes/no)? yes
ok: [web.example.com]

TASK [Update apt cache] *******************************************************************************************************************************************************************************************
[WARNING]: Could not find aptitude. Using apt-get instead

changed: [web.example.com]

TASK [Install Packages] *******************************************************************************************************************************************************************************************
changed: [web.example.com]

TASK [Create .aws directory] **************************************************************************************************************************************************************************************
changed: [web.example.com]

TASK [Create config directory] ************************************************************************************************************************************************************************************
changed: [web.example.com] => (item=/home/ubuntu/letsencrypt/config)
changed: [web.example.com] => (item=/home/ubuntu/letsencrypt/log)
changed: [web.example.com] => (item=/home/ubuntu/letsencrypt/work)
changed: [web.example.com] => (item=/home/ubuntu/modlishka/)

TASK [Add AWS CLI credentials] ************************************************************************************************************************************************************************************
changed: [web.example.com]

TASK [Add AWS CLI config] *****************************************************************************************************************************************************************************************
changed: [web.example.com]

TASK [Get TLS certificate] ****************************************************************************************************************************************************************************************
changed: [web.example.com]

TASK [Download modlishka] *****************************************************************************************************************************************************************************************
changed: [web.example.com]

TASK [Download example google config] *****************************************************************************************************************************************************************************
changed: [web.example.com]

TASK [Download example office config] *****************************************************************************************************************************************************************************
changed: [web.example.com]

PLAY RECAP ********************************************************************************************************************************************************************************************************
web.example.com        : ok=11   changed=10   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

You can then ssh into the box and use modlishka

```bash
$ sudo modlishka
```
