Feature: Remote Server Configuration
  In order to type less
  As a programmer
  I want to be able to set default values for remote servers
  so I don't have to keep typing them

  Background:
    Given there are no settings saved

  Scenario: Adding a remote server 
     When I run `gitinit remote add origin git@server.local`
     Then the output should contain "Remote 'origin' set to 'git@server.local'"

  Scenario: Removing a remote server 
    Given I run `gitinit remote add origin git@server.local`
     When I run `gitinit remote remove origin`
     Then the output should contain "Remote 'origin' removed"

  Scenario: Removing a remote server that doesn't exist
     When I run `gitinit remote remove blorp`
     Then the output should contain "Remote 'blorp' does not exist"

  Scenario: Listing remote servers
    Given I run `gitinit remote add origin git@server.local`
      And I run `gitinit remote add github git@github.com`
      And I run `gitinit remote add mirror git@mirror.local`
     When I run `gitinit remote list`
     Then the output should contain: 
      """
      origin: git@server.local
      github: git@github.com
      mirror: git@mirror.local
      """

  Scenario: Listing remote servers when there are none
     When I run `gitinit remote list`
     Then the output should contain: 
      """
      There are no remote servers configured.
      """
