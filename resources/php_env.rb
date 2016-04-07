resource_name :php_env

property :cli_package,  String, name_property: true
property :config_file,  String, default: '/etc/php.ini'
property :php_options,  Hash

action :create do
  php_package cli_package do
    php_package_options '--enablerepo=webtatic' if node['cog_php']['webtatic-php7'] == true
    action :install
  end

  template config_file do
    php_options_hash = node['cog_php']['php_ini'].merge(php_options)
    path config_file
    source 'php.ini.erb'
    cookbook 'cog_php'
    owner 'root'
    group 'root'
    mode 00644
    variables(php_options: php_options_hash)
  end
end

action :remove do
  file config_file do
    path config_file
    action :delete
  end

  php_package cli_package do
    php_package_options '--enablerepo=webtatic' if node['cog_php']['webtatic-php7'] == true
    action :remove
  end
end
