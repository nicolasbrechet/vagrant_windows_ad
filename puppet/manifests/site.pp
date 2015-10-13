node default {

  class {'windows_ad':
    install                => present,
    installmanagementtools => true,
    restart                => true,
    installflag            => true,
    configure              => present,
    configureflag          => true,
    domain                 => 'forest',
    domainname             => 'corp.nbt.com',
    netbiosdomainname      => 'nbt',
    domainlevel            => '6',
    forestlevel            => '6',
    databasepath           => 'c:\\windows\\ntds',
    logpath                => 'c:\\windows\\ntds',
    sysvolpath             => 'c:\\windows\\sysvol',
    installtype            => 'domain',
    dsrmpassword           => 'Micr0s0ftP@r@noid',
    installdns             => 'yes',
    localadminpassword     => 'Micr0s0ftP@r@noid',
  }
    
  windows_ad::organisationalunit{'RAILSAPP':
    ensure       => present,
    path         => 'DC=CORP,DC=NBT,DC=COM',
    ouName       => 'RAILSAPP',
  }
    
  windows_ad::organisationalunit{'RAILSAPPADMIN':
    ensure       => present,
    path         => 'DC=CORP,DC=NBT,DC=COM',
    ouName       => 'RAILSAPPADMIN',
  }
    
  $userhash = {
    'user1' => {
      ensure               => present,
      path                 => 'OU=RAILSAPP,DC=CORP,DC=NBT,DC=COM',
      accountname          => 'railsuser',
      lastname             => 'user',
      firstname            => 'rails',
      passwordneverexpires => true,
      password             => '@wes0meP@$$',
      passwordlength       => 11,
      fullname             => 'Rails User',
      emailaddress         => 'user@corp.nbt.com',
    },
    'user2' => {
      ensure               => present,
      path                 => 'OU=RAILSAPPADMIN,DC=CORP,DC=NBT,DC=COM',
      accountname          => 'railsadmin',
      lastname             => 'admin',
      firstname            => 'rails',
      passwordneverexpires => true,
      password             => '@wes0meP@$$',
      passwordlength       => 11,
      fullname             => 'Rails Admin',
      emailaddress         => 'admin@corp.nbt.com',
    },
    'user3' => {
      ensure               => present,
      path                 => 'OU=RAILSAPP,DC=CORP,DC=NBT,DC=COM',
      accountname          => 'railsuser2',
      lastname             => 'user2',
      firstname            => 'rails',
      passwordneverexpires => true,
      password             => '@wes0meP@$$',
      passwordlength       => 11,
      fullname             => 'Rails User2',
      emailaddress         => 'user2@corp.nbt.com',
    },
    'user4' => {
      ensure               => present,
      path                 => 'OU=RAILSAPPADMIN,DC=CORP,DC=NBT,DC=COM',
      accountname          => 'railsadmin2',
      lastname             => 'admin2',
      firstname            => 'rails',
      passwordneverexpires => true,
      password             => '@wes0meP@$$',
      passwordlength       => 11,
      fullname             => 'Rails Admin2',
      emailaddress         => 'admin2@corp.nbt.com',
    }
  }

  windows_ad::group{'railsapp':
    ensure               => present,
    displayname          => 'Rails App',
    path                 => 'CN=Users,DC=CORP,DC=NBT,DC=COM',
    groupname            => 'railsapp',
    groupscope           => 'Global',
    groupcategory        => 'Security',
    description          => 'a group with all the Rails App users',
  }->
  windows_ad::groupmembers{'Members of group railsapp':
    ensure    => present,
    groupname => 'railsapp',
    members   => '"railsuser","railsuser2","railsadmin","railsadmin2"',
  }
    
  windows_ad::group{'railsappadmin':
    ensure               => present,
    displayname          => 'Rails App Admin',
    path                 => 'CN=Users,DC=CORP,DC=NBT,DC=COM',
    groupname            => 'railsappadmin',
    groupscope           => 'Global',
    groupcategory        => 'Security',
    description          => 'a group with all the Rails App Admin users',
  }-> 
  windows_ad::groupmembers{'Members of group railsappadmin':
    ensure    => present,
    groupname => 'railsappadmin',
    members   => '"railsadmin","railsadmin2"',
  }

  create_resources(windows_ad::user, $userhash)
  
  
  
  Class['windows_ad'] 
  -> Windows_ad::Organisationalunit <||>
  -> Windows_ad::User <||>

  Windows_ad::User <||>
  -> Windows_ad::Groupmembers <||>

  Windows_ad::Group <||>
  -> Windows_ad::Groupmembers <||>
}