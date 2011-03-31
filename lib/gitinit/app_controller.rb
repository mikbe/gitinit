module GitInit
  
  class AppController
  class << self
    extend Commandable 
    
    command "configure remote servers"
    def remote(cmd, *args)
      case cmd
        when "add"
          Configure.add("remote", args[0] => args[1])
          "Remote '#{args[0]}' set to '#{Configure.remote[args[0]]}'"
        when "remove"
          if Configure.remove("remote", args[0] => args[1])
            "Remote '#{args[0]}' removed"
          else
            "Remote '#{args[0]}' does not exist"
          end
        when "list"
          return "There are no remote servers configured." unless Configure.respond_to?(:remote)
          Configure.remote.collect {|key, value| "#{key}: #{value}"}
      end
    end
    
  end
  end
  
end