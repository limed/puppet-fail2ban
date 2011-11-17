# fail2ban::params class - we set our variables here
#

class fail2ban::params {

    $packagename = $operatingsystem ? {
        default => "fail2ban",
    }

    $servicename = $operatingsystem ? {
        default => "fail2ban",
    }

    $processname = $operatingsystem ? {
        default => "fail2ban-server",
    }

    $configdir  = $operatingsystem ? {
        default => "/etc/fail2ban",
    }

    $configfile = $operatingsystem ? {
        default => "/etc/fail2ban/jail.conf",
    }

    $ignore = $fail2ban_ignore ? {
        ''      => [ "*.$domain", "127.0.0.1" ],
        default => $fail2ban_ignore,
    }

    $bantime = $fail2ban_bantime ? {
        ''      => "1200",
        default => $fail2ban_bantime
    }

    $maxretry = $fail2ban_maxretry ? {
        ''      => "3",
        default => $fail2ban_maxretry
    }

    $destemail = $fail2ban_destemail ? {
        ''      => "root@$domain",
        default => $fail2ban_destemail,
    }

}
