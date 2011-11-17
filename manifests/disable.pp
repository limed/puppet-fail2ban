# fail2ban::disable class - Disables the service
#
# Usage:
#   include fail2ban::disable

class fail2ban::disable inherits fail2ban {

    Service["fail2ban"] {
        ensure  => "stopped",
        enable  => false
    }

}
