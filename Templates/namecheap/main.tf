resource "namecheap_domain_records" "papashells" {
  domain = "papashells-com"
  mode = "OVERWRITE"
  email_type = "MX"

variable "onmicrosoft_domain" {
  type = string
  default = "123XYZ.onmicrosoft.com"
}

  record {
    hostname = "@"
    type = "TXT"
    address = "MS=ms12345678"
  }

  record {
    hostname = "@"
    type = "TXT"
    address = "v=spf1 include:spf.protection.outlook.com -all"
  }

  record {
    hostname = "@"
    type = "MX"
    address = "revolutionarypublishing-com.mail.protection.outlook.com"
  }

  record {
    hostname = "selector1._domainkey"
    type = "CNAME"
    address = "selector1-revolutionarypublishing-com._domainkey.${var.onmicrosoft_domain}"
  }

  record {
    hostname = "selector2._domainkey"
    type = "CNAME"
    address = "selector2-revolutionarypublishing-com._domainkey.${var.onmicrosoft_domain}"
  }

  record {
    hostname = "autodiscover"
    type = "CNAME"
    address = "autodiscover.outlook.com"
  }

  record {
    hostname = "sip"
    type = "CNAME"
    address = "sipdir.online.lync.com"
  }

  record {
    hostname = "lyncdiscover"
    type = "CNAME"
    address = "webdir.online.lync.com"
  }

  record {
    hostname = "msoid"
    type = "CNAME"
    address = "clientconfig.microsoftonlines.net"
  }

  record {
    hostname = "enterpriseregistration"
    type = "CNAME"
    address = "enterpriseregistration.windows.net"
  }

  record {
    hostname = "enterpriseenrollment"
    type = "CNAME"
    address = "enterpriseenrollment-s.manage.microsoft.com"
  }

}

