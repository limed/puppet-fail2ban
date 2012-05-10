
class fail2ban::params {

    $packagename    = 'fail2ban'
    $servicename    = 'fail2ban'
    $servicepattern = '/usr/bin/python /usr/bin/fail2ban-server'
    $processname    = 'fail2ban-server'
    $configdir      = '/etc/fail2ban'
    $configfile     = '/etc/fail2ban/jail.conf'

}
