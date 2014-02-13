exec { "apt-get update":
  path => "/usr/bin",
}

node default {
  class { 'ldap':
    server      => true,
    ssl         => false,
  }
}

ldap::define::domain {'brodate.test':
  basedn   => 'dc=brodate,dc=net',
  rootdn   => 'cn=dsadmin',
  rootpw   => 'test',
  auth_who => 'anonymous'
}

ldap::define::schema {'brodate':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/brodate.schema',
}

ldap::define::schema {'sudo':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/sudo.schema',
}

ldap::define::schema {'misc':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/misc.schema',
}

ldap::define::schema {'openssh':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/openssh.schema',
}

ldap::define::schema {'inetorgperson':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/inetorgperson.schema',
}

ldap::define::schema {'nis':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/nis.schema',
}
