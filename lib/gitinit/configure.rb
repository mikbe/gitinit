module GitInit
  
  # Simple hash to store values
  # key => {hash1, hash2, hash3, etc.}
  class Configure
  class << self

    def add(key, hash)
      if self.instance_variable_get("@#{key}").nil?
        self.class.__send__(:attr_accessor, key)
        self.__send__("#{key}=", hash)
      else
        instance_eval("@#{key}.merge!(#{hash})")
      end
      !!save_state
    end

    def remove(key, sub_key)
      unless self.instance_variable_get("@#{key}").nil? 
        instance_eval("@#{key}.delete(#{sub_key.inspect})") 
        !!save_state
      else
        false
      end
    end

    def clear_and_save
      clear_state
      save_state
    end

    def clear_state
      instance_variables.each do |var|
        remove_instance_variable(var)
      end
    end

    def reload_state
      config = instance_eval IO.read(CONFIG_FILE)
      config.each do |key, value|
        add(key.to_s.sub('@',''), value)
      end
    end
    
    def save_state
      config = self.instance_variables.each_with_object({}) do |var, hash|
        hash.merge!(var=>self.instance_variable_get(var)) if self.instance_variable_get(var)
      end
      File.open(CONFIG_FILE, "w") {|f| f.write(config)}
    end

    private 

    CONFIG_FILE = File.expand_path(File.join(File.dirname(__FILE__), "/../../db/config.dat")) unless defined? CONFIG_FILE
    
  end
  reload_state
  end

end
