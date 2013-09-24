# devel base profile
[root@cworld .ssh]# yum list '*guestf*x86_64*'
Loaded plugins: langpacks, refresh-packagekit
Available Packages
erlang-libguestfs.x86_64                     1:1.22.6-1.fc19             updates
guestfs-browser.x86_64                       0.2.2-1.fc19                fedora 
libguestfs.x86_64                            1:1.22.6-1.fc19             updates
libguestfs-bash-completion.x86_64            1:1.22.6-1.fc19             updates
libguestfs-devel.x86_64                      1:1.22.6-1.fc19             updates
libguestfs-gobject.x86_64                    1:1.22.6-1.fc19             updates
libguestfs-gobject-devel.x86_64              1:1.22.6-1.fc19             updates
libguestfs-java.x86_64                       1:1.22.6-1.fc19             updates
libguestfs-java-devel.x86_64                 1:1.22.6-1.fc19             updates
libguestfs-javadoc.x86_64                    1:1.22.6-1.fc19             updates
libguestfs-live-service.x86_64               1:1.22.6-1.fc19             updates
libguestfs-man-pages-ja.x86_64               1:1.22.6-1.fc19             updates
libguestfs-man-pages-uk.x86_64               1:1.22.6-1.fc19             updates
libguestfs-tools.x86_64                      1:1.22.6-1.fc19             updates
libguestfs-tools-c.x86_64                    1:1.22.6-1.fc19             updates
lua-guestfs.x86_64                           1:1.22.6-1.fc19             updates
nbdkit-plugin-guestfs.x86_64                 1.1.2-3.fc19                updates
ocaml-libguestfs.x86_64                      1:1.22.6-1.fc19             updates
ocaml-libguestfs-devel.x86_64                1:1.22.6-1.fc19             updates
perl-Sys-Guestfs.x86_64                      1:1.22.6-1.fc19             updates
php-libguestfs.x86_64                        1:1.22.6-1.fc19             updates
python-libguestfs.x86_64                     1:1.22.6-1.fc19             updates
ruby-libguestfs.x86_64                       1:1.22.6-1.fc19             updates


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
