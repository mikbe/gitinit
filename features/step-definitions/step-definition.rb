Given /^there are no settings saved$/ do
  GitInit::Configure.clear_and_save
end