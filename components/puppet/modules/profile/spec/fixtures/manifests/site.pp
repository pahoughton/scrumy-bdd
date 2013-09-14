$extlookup_datadir = 'spec/fixtures/extdata'
$extlookup_precedence = ['%{fqdn}', 'domain_%{domain}', 'common']
node default {
  notify { 'test': }
}
