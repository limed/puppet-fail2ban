# fail2ban::absent class, this ensures that the package is removed
#
# Usage:
#   fail2ban::absent

class fail2ban::absent inherits fail2ban {

    Package["fail2ban"] {
        ensure  => "absent",
    }
}
