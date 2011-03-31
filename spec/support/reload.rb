def reset(klass_module)

  klass_module.instance_variables.each do |var|
    klass_module.instance_variable_set(var, nil)
  end
  
end