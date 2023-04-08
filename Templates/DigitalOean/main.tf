variable "domain_name" {
  type = string
  default = "frankocean-com"
}

variable "verification_record" {
  type = string
  default = "MS=ms12391237"
}

variable "do_token" {
  type = string
  default = "your_digitalocean_api_token_here"
}

variable "onmicrosoft_domain" {
  type = string
  default = "123XYZ.onmicrosoft.com"
}

// DigitalOcean domain
resource "digitalocean_domain" "default" {
  name = var.domain_name
}

// DNS records
record {
  name = "@"
  type = "TXT"
  data = var.verification_record
  ttl = 3600
}

record {
  name = "@"
  type = "TXT"
  data = "v=spf1 include:spf.protection.outlook.com -all"
  ttl = 3600
}

record {
  name = "@"
  type = "MX"
  data = "${var.domain_name}.mail.protection.outlook.com"
}

record {
  name = "selector1._domainkey"
  type = "CNAME"
  data = "selector1-${var.domain_name}._domainkey.${var.onmicrosoft_domain}"
  ttl = 3600
}

record {
  name = "selector2._domainkey"
  type = "CNAME"
  data = "selector2-${var.domain_name}._domainkey.${var.onmicrosoft_domain}"
  ttl = 3600
}

record {
  name = "autodiscover"
  type = "CNAME"
  data = "autodiscover.outlook.com"
  ttl = 3600
}

record {
  name = "sip"
  type = "CNAME"
  data = "sipdir.online.lync.com"
  ttl = 3600
}

record {
  name = "lyncdiscover"
  type = "CNAME"
  data = "webdir.online.lync.com"
  ttl = 3600
}

record {
  name = "msoid"
  type = "CNAME"
  data = "clientconfig.microsoftonline-p.net"
  ttl = 3600
}

record {
  name = "enterpriseregistration"
  type = "CNAME"
  data = "enterpriseregistration.windows.net"
  ttl = 3600
}

record {
  name = "enterpriseenrollment"
  type = "CNAME"
  data = "enterpriseenrollment-s.manage.microsoft.com"
  ttl = 3600
}

// MX record
resource "digitalocean_record" "mx" {
  domain   = digitalocean_domain.default.id
  type     = "MX"
  name     = "@"
  priority = 10
  value    = "${var.domain_name}.mail.protection.outlook.com"
}

// TXT record
resource "digitalocean_record" "TXT" {
  domain   = digitalocean_domain.default.id
  type     = "TXT"
  name     = "@"
  priority = 10
  value    = "v=spf1 include:spf.protection.outlook.com -all"
}

// Output the FQDN for the www A record.
output "www_fqdn" {
  value = digitalocean_record.www.fqdn # => www.example.com
}

// Output the FQDN for the MX record.
output "mx_fqdn" {
  value = digitalocean_record.mx.fqdn # => example.com
}
