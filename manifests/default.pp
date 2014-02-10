exec { "apt-get update":
  path => "/usr/bin",
}

node default {
  class { 'ldap':
    server      => true,
    ssl         => false,
  }
}

ldap::define::schema {'mochi.schema':
  ensure => 'present',
  source => 'puppet:///modules/ldap/schema/mochi.schema',
}

ldap::define::domain {'puppetlabs.test':
  basedn   => 'dc=puppetlabs,dc=test',
  rootdn   => 'cn=admin',
  rootpw   => 'test',
  auth_who => 'anonymous'
}
