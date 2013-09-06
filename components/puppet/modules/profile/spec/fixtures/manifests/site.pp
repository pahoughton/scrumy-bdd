#$extlookup_datadir = "/home/paul/Devel/Systems/pah_test_host/components/puppet/modules/profile/spec/fixtures/extdata"
$extlookup_datadir = "spec/fixtures/extdata"
$extlookup_precedence = ["%{fqdn}", "domain_%{domain}", "common"]
node default {
  notify { 'test': }
}
