# devel base profile

define profile::virt_domain (
  $os = 'centos-6.4-x86_64'
) {

  $domain_xml_fn = "/tmp/${title}.virt.xml"
  # Note the 10g image was too big fir puppet filebucket :(
  $domain_image_src = "/var/lib/puppet/files/${os}.domain.img"

  file { $domain_image_src :
    ensure    => 'exists'
  }
  ->
  file { $domain_xml_fn :
    ensure    => 'exists',
    content   => template("profile/domain.virt.${os}.xml.erb")
  }
}
