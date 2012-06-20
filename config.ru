require 'rbconfig'

class ShellyOSCheck
  def os
    RbConfig::CONFIG['host_os']
  end
  
  def os_version
    return @os_version if defined? @os_version
    os_version = case os
    when /linux/ then `lsb_release -a`
    when /darwin/ then `sw_vers -productVersion`
    else "who knows?"
    end
    @os_version = "%s\n%s\n" % [os, os_version]
  end

  def call(env)
    [200, {"Content-Type" => "text/plain"},[os_version]]
  end
end

run ShellyOSCheck.new
