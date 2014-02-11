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
