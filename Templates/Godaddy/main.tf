variable "domain_name" {
  description = "Name of the domain"
  default = "phisherylovescompany-com"
}

variable "customer_id" {
  type = string
  default = "22222222"
}

variable "onmicrosoft_domain" {
  type = string
  default = "123XYZ.onmicrosoft.com"
}

variable "verification_record" {
  description = "MS verification record"
  default = "MS=ms11111111" # Record MS gives you after adding a custom domain in AzureAD
}

variable "o365_protection" {
  description = "Office 365 protection domain"
  default = "spf.protection.outlook.com"
}

variable "mail_protection" {
  description = "Mail protection domain"
  default = "mail.protection.outlook.com"
}

resource "godaddy_domain_record" "gd-domain" {
  domain   = var.domain_name

  // required if provider key does not belong to customer
   customer = "${var.customer_id}"

  // specify zero or more record blocks
  // a record block allows you to configure A, or NS records with a custom time-to-live value
  // a record block also allow you to configure AAAA, CNAME, TXT, or MX records

  // AZAD/O365 Custom Domaun TXT Record 
  record {
    name = "@"
    type = "TXT"
    data = var.verification_record
    ttl = 3600
  }

  // SPF and Custom MX
  record {
    name = "@"
    type = "TXT"
    data = "v=spf1 include:${var.o365_protection} -all"
    ttl = 3600
  }

    record {
    name = "@"
    type = "MX"
    data = "${var.domain_name}.${var.mail_protection}"
  }

// CNAMES for DKIM keys
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

  // Records for autpdiscover, enterprise enrollment, etc
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
    data = "clientconfig.microsoftonline.net"
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
}

