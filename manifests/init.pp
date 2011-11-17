# main fail2ban class
#
# Usage:
#   include fail2ban

class fail2ban {

    require fail2ban::params

    # Reset variables needed in templates
    $fail2ban_ignore    = $fail2ban::params::ignore
    $fail2ban_bantime   = $fail2ban::params::bantime
    $fail2ban_maxretry  = $fail2ban::params::maxretry
    $fail2ban_destemail = $fail2ban::params::destemail

    package { "fail2ban":
        name    => "${fail2ban::params::packagename}",
        ensure  => present
    }

    service { "fail2ban":
        ensure      => running,
        name        => "${fail2ban::params::servicename}",
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        pattern     => "${fail2ban::params::processname}",
        require     => Package["fail2ban"],
    }

    file { "jail.conf":
        ensure  => present,
        path    => "${fail2ban::params::configfile}",
        owner   => root,
        group   => root,
        mode    => '0644',
        require => Package["fail2ban"],
        notify  => Service["fail2ban"],
    }

    file { "jail.local":
        ensure  => present,
        path    => "${fail2ban::params::configdir}/jail.local",
        owner   => root,
        group   => root,
        mode    => '0644',
        require => Package["fail2ban"],
        content => template("fail2ban/jail.local.erb"),
        notify  => Service["fail2ban"],
    }

}
