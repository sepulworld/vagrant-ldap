exec { "apt-get update":
  path => "/usr/bin",
}

$testdata = "output-uids.ldif"

node default {
  class { 'ldap':
    server      => true,
    ssl         => false,
    before      => Exec["${testdata}"],
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

file {
  '/etc/ldap/schema/nis.schema':
    ensure => file,
    source => 'puppet:///modules/ldap/schema/nis.schema';
  }

ldap::define::schema {'dyngroup':
  ensure => present,
  source => 'puppet:///modules/ldap/schema/dyngroup.schema',
}

exec {"$testdata":
  require   => [Ldap::Define::Schema["dyngroup", "inetorgperson", "brodate", "sudo", "misc", "openssh"], File["/etc/ldap/schema/nis.schema"]], 
  command   => "/usr/bin/ldapadd -w test -D 'cn=dsadmin,dc=brodate,dc=net' -H ldap://localhost -f /vagrant_data/deploy/${testdata}"
}

exec {'input_ldap_test_data.ldif':
  require   => [Ldap::Define::Schema["dyngroup", "inetorgperson", "brodate", "sudo", "misc", "openssh"], File["/etc/ldap/schema/nis.schema"], Exec["$testdata"]], 
  command   => '/usr/bin/ldapadd -w test -D "cn=dsadmin,dc=brodate,dc=net" -H ldap://localhost -f /vagrant_data/deploy/ldap_test_data.ldif -c'
}
