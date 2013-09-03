# www bugzilla provider Fix dependancy issue
class profile::bugzilla {
  #class { 'postgres': }
  class { 'profile::www': }
  #class { 'fcgiwrap': }
  #class { 'bugzilla': }
}
