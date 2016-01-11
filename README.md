# PHP custom resources

Chef custom resource to manage php environments

## Supported Platforms

- Amazon linux

## Usage

### php_env
- use to install basic php package and configure php.ini

    php_env 'php-package' do
      config_path '/path/to/configuration-directory'
      config_file     'name-of-config-file'
      php_options  { 'key' => 'value'}            # set values with stringified
                                                  # double quotes, i.e. '"value"'
                                                  # to avoid php parsing errors
      action :create, :remove
    end

### php_fpm_pool
- use to install php-fpm package and configure pool configuration
- TODO: should include global php-fpm configuration

    php_fpm_pool 'pool-name' do
      config_path       '/path/to/configuration-directory'
      config_file       'name-of-config-file'
      pool_name         'pool name'
      fpm_package       'package-name'
      service_name      'service-name'
      process_manager   'dynamic' || 'ondemand'
      user              'user'
      group             'group'
      listen            'ip:port' || '/path/to/socket'
      allowed_clients   '['ip1', 'ip2', ...]'
      max_children      Integer
      start_servers     Integer
      min_spare_servers Integer
      max_spare_servers Integer
      max_requests      Integer
      pm_status_path    '/status'
      ping_path         '/ping'
      php_options       { 'key' => 'value'}       # set values with stringified
                                                  # double quotes, i.e. '"value"'
                                                  # to avoid php parsing errors
      action            :create, :remove
    end


### php_module

- use to install basic php package and configure php.ini

### php_package

- used internally to install packages

## License and Authors

Author:: Andreas Wagner (<andreas.wagner@cashongo.co.uk>)
