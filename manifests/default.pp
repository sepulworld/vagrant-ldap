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
  basedn   => 'dc=puppetlabs,dc=test',
  rootdn   => 'cn=admin',
  rootpw   => 'test',
  auth_who => 'anonymous'
}
