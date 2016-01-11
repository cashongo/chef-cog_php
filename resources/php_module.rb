resource_name :php_module

property :module_name,    String, name_property: true
property :module_package, String
property :config_file,    String
property :config_path,    String
property :module_options,    Hash

action :create do
  php_package module_package do
    action :install
  end

  template config_file do
    path        config_path + config_file
    source      'php_module.conf.erb'
    cookbook    'cog_php'
    owner       'root'
    group       'root'
    mode        00644
    variables(  :module_options => module_options_hash )
  end
end

action :remove do
  file config_file do
    path    config_path
    action  :delete
  end

  php_package cli_package do
    # php_package_options '--enablerepo=epel'               # prep for remi
    action :remove
  end
end
