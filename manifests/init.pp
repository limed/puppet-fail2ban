
class fail2ban(
    $ensure     = present,
    $bantime    = '1200',
    $ignore     = ['*.$::domain', '127.0.0.1'],
    $maxretry   = '3',
    $email      = "root@${::domain}") {

    include fail2ban::params

    if ! ($ensure in ['present','absent']) {
        fail('fail2ban module requires present or absent')
    }

    if $ensure == present {
        $package_ensure = present
        $service_ensure = running
        $service_enable = true
    }
    else {
        $package_ensure = absent
        $service_ensure = stopped
        $service_enable = false
    }

    validate_array($ignore)

    package { 'fail2ban':
        ensure  => $package_ensure,
        name    => $fail2ban::params::packagename,
    }

    service { 'fail2ban':
        ensure      => $service_ensure,
        name        => $fail2ban::params::servicename,
        enable      => $service_enable,
        hasstatus   => true,
        hasrestart  => true,
        pattern     => $fail2ban::params::processname,
        require     => Package['fail2ban'],
    }

    file { 'jail.conf':
        ensure  => present,
        path    => $fail2ban::params::configfile,
        owner   => root,
        group   => root,
        mode    => '0644',
        require => Package['fail2ban'],
        notify  => Service['fail2ban'],
    }

    file { 'jail.local':
        ensure  => present,
        path    => "${fail2ban::params::configdir}/jail.local",
        owner   => root,
        group   => root,
        mode    => '0644',
        require => Package['fail2ban'],
        content => template('fail2ban/jail.local.erb'),
        notify  => Service['fail2ban'],
    }

}
