$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "/../lib"))
require 'gitinit'

# Require support files
Dir["#{File.expand_path(File.join(File.dirname(__FILE__)))}/support/**/*.rb"].map {|f| require f}
