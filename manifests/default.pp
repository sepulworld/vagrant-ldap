exec { "apt-get update":
  path => "/usr/bin",
}

node default {
  class { 'ldap':
    server      => true,
    ssl         => false,
  }
}

ldap::define::domain {'puppetlabs.test':
  basedn   => 'dc=mochimedia,dc=net',
  rootdn   => 'cn=dsadmin',
  rootpw   => 'test',
  auth_who => 'anonymous'
}

ldap::define::schema {'inetorgperson':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/inetorgperson.schema',
}

ldap::define::schema {'mochi':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/mochi.schema',
}
