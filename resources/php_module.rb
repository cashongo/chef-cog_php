resource_name :php_module

property :module_name, String, name_property: true
property :config_file, String, default: @module_name
property :config_path, String, default: '/etc/php.d'
property :module_options, Hash

action :create do
  php_package module_name do
    php_package_options '--enablerepo=webtatic' if node['cog_php']['webtatic-php7'] == true
    action :install
  end

  unless module_options.empty?
    template config_file do
      path config_file
      source 'php_module.conf.erb'
      cookbook 'cog_php'
      owner 'root'
      group 'root'
      mode 00644
      variables(module_options: module_options)
    end
  end
end

action :remove do
  unless module_options.empty?
    file config_file do
      path config_path
      action :delete
    end
  end

  php_package module_name do
    php_package_options '--enablerepo=webtatic' if node['cog_php']['webtatic-php7'] == true
    action :remove
  end
end
