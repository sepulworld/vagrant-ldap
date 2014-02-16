vagrant-ldap
============

Vagrant for OpenLDAP testing

Provide custom schemas in /modules/ldap/files/schema/

Clone then run 

```
vagrant up ; vagrant ssh
```
You are now able to query the vagrant built OpenLDAP server via 127.0.0.1:389 

jfryman/puppet-openldap openldap module used as submodule

Random LDAP entries generated and loaded via output.ldif (http://ldapwiki.willeke.com/wiki/LDIF%20Generator)
