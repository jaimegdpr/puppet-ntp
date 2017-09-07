# @api private
# This class handles the ntp service. Avoid modifying private classes.
class ntp::service inherits ntp {

  if $ntp::service_manage == true {

    if ($osfamily == 'Redhat') and ($operatingsystemmajrelease == '7') {
        service { 'chronyd':
          ensure     => stopped,
          enable     => false,
          hasstatus  => true,
          hasrestart => true,
          before => Service['ntpdate'],
        }
    }

    service { 'ntpdate':
      ensure     => $ntp::service_ensure,
      enable     => $ntp::service_enable,
      provider   => $ntp::service_provider,
      hasstatus  => true,
      hasrestart => true,
      before => Service['ntpd'],
    }

    service { 'ntp':
      ensure     => $ntp::service_ensure,
      enable     => $ntp::service_enable,
      name       => $ntp::service_name,
      provider   => $ntp::service_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
