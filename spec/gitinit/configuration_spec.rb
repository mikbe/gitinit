require 'spec_helper'

describe GitInit::Configure do
  
  before(:each) do
    GitInit::Configure.clear_and_save
  end
  
  context "when configuring default settings" do
    
    it "should add settings dynaically" do
      setting = "setting_#{rand(10000)}"
      value = {"value"=>"#{rand(10000)}"}
      GitInit::Configure.add(setting, value)
      instance_eval("GitInit::Configure.#{setting}").should == value
    end
    
    it "should be clearable" do
      GitInit::Configure.add("remote", "origin" => "git@server.local")
      lambda{GitInit::Configure.clear_state}.should change{GitInit::Configure.instance_variables.count}.to(0)
    end
    
    context "and adding values" do
      
      it {lambda{GitInit::Configure.add("remote", "origin" => "git@server.local")}.should change{GitInit::Configure.remote}}
      
      it "should add new values, not just overwrite the old ones" do
        GitInit::Configure.add("remote", "origin" => "git@server.local")
        GitInit::Configure.add("remote", "github" => "git@github.com")
        GitInit::Configure.remote.should include("origin")
      end
      
      it "should overwrite existing values" do
        GitInit::Configure.add("remote", "origin" => "git@server.local")
        lambda{GitInit::Configure.add("remote", "origin" => "git@github.com")}.should 
          change{GitInit::Configure.remote["origin"]}
          .from("git@server.local")
          .to("git@github.com")
      end
      
    end
    
    context "and removing values" do
      
      it "should add new values, not just overwrite the old ones" do
        GitInit::Configure.add("remote", "origin" => "git@server.local")
        GitInit::Configure.add("remote", "github" => "git@github.com")
        GitInit::Configure.remove("remote", "origin")
        GitInit::Configure.remote.should_not include("origin")
      end
      
      it "should not raise an error if we try to delete a non-existent value" do
        lambda{GitInit::Configure.remove("potato", "sweet")}.should_not raise_error
      end
      
      it "should return false if we try to delete a non-existent value" do
        GitInit::Configure.remove("potato", "sweet").should be_false
      end
      
    end
  
    context "and reloading values" do
      
      it "should remember previously stored values" do
        GitInit::Configure.add("remote", "origin" => "git@server.local")
        GitInit::Configure.clear_state
        lambda{GitInit::Configure.reload_state}.should 
          change{GitInit::Configure.remote}
          .from(nil)
          .to("origin"=>"git@server.local")
      end
      
    end
  
  end
  
end