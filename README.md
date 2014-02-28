vagrant-ldap
============

Vagrant for OpenLDAP testing

Provide custom schemas in /modules/ldap/files/schema/  Then define them in manifests/default.pp

in ldap/output.ldif there is 1000 randomly generated directory users and information.  You can add your own users and attributes here if you would like.  Just make sure you follow OpenLDAP default schemas or install your own schemas for testing.

Also, ldap/output-uids.ldif has random users associated using uid instead of cn value.

You can switch between the 2 user entry variations by modifying the $testdata variable in manifests/default.pp

Clone this repo then run 

```
vagrant up ; vagrant ssh
```
You are now able to query the vagrant built OpenLDAP server via 127.0.0.1:389 

You can update the domain to something other than what I have it set to, dc=brodate,dc=net.  I also, set the admin user to "cn=dsadmin,dc=brodate,dc=net".  These settings can be changed in the manifests/default.pp puppet manifest.

Example searches after vagrant up:

```
ldapsearch -w test -D "cn=dsadmin,dc=brodate,dc=net" -b "dc=brodate,dc=net" -h localhost:3890

returns entire directory
```

```
ldapsearch -w test -D "cn=dsadmin,dc=brodate,dc=net" -b "dc=brodate,dc=net" -h localhost:3890 uid=KielstrG

returns KielstrG uid directory listing
```
jfryman/puppet-openldap openldap module used as submodule

Random LDAP entries generated and loaded via output.ldif (http://ldapwiki.willeke.com/wiki/LDIF%20Generator)
