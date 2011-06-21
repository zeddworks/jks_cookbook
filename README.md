Description
===========

Generates a Java Key Store with default JVM CA certificates and a certificate signed by a Microsoft CA Server

Requirements
============

* Microsoft Active Directory Certificate Services
* User with access to Active Directory Certificate Services

Attributes
==========

* subject: X509 Certificate Subject e.g. "CN=example.example.com, OU=Example, O=Example, L=Atlanta, ST=GA, C=US", defaults to name_attribute
* ca_url: Full URL to Microsoft Active Directory Certificate Services "https://example.example.com/certsrv/"
* ca_user: User with access to Microsoft Active Directory Certificate Services
* ca_pass: ca_user's password
* store_pass: Password to be set on the newly created keystore e.g. "changeit"
* user_agent: Identification String used to convince Active Directory
  Certificate Services that the provider is a web browser e.g. for IE9 "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"
* jks_path: Fully qualified path and name of the JKS file to be created or modified

Usage
=====
Create a data bag - in this case example data bag "zw" has been created with item "ca"

The contents of the "ca" item are as follows:

```json
{
  "id": "ca",
  "ca_url": "https://example.example.com/certsrv/",
  "ca_user": "ficticious_user",
  "cn_pass": "ficticious_password",
  "store_pass": "ficiticious_password",
  "user_agent": "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"
}
```

Create a data bag for your application - in this case the example data bag "apps" has been created with item "yourapp"

The contents of the "yourapp" item are as follows:
```json
{
  "httpsPort": "8443",
  "ca_subject": "CN=www.fictitious-company.com, OU=Ficticious Engineering, O=Ficticious Company, L=Atlanta, ST=GA, C=US",
  "id": "yourapp",
  "store_pass": "ficitious_password",
  "jks_path": "/var/lib/yourapp/keystore.jks"
}

Create the keystore in your recipe using the following:

```ruby
yourapp = Chef::EncryptedDataBagItem.load("apps", "yourapp")
ca = Chef::EncryptedDataBagItem.load("zw", "ca")

zw_jks_keystore yourapp["ca_subject"] do
  subject yourapp["ca_subject"]
  ca_url ca['ca_url']
  ca_user ca['ca_user']
  ca_pass ca['ca_pass']
  store_pass ca['store_pass']
  user_agent ca['user_agent']
  jks_path "/srv/keystore.jks"
  action :create
  provider "zw_jks_keystore"
end
```
