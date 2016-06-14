resource_name :php_fpm_service

property :fpm_package, String, name_property: true
property :fpm_config_file, String, default: '/etc/php-fpm.conf'
property :pool_config_directory, String, default: '/etc/php-fpm.d'
property :service_name, String, default: 'php-fpm'
property :pid, String, default: '/var/run/php-fpm.pid'
property :error_log, String, default: '/var/log/php-fpm/error.log'
property :log_level, String, default: 'notice'
property :daemonize, String, default: 'yes'
property :fpm_options, Hash, default: {}

action :create do
  php_package fpm_package do
    php_package_options '--enablerepo=webtatic' if node['cog_php']['webtatic-php7'] == true
    action :install
  end

  template fpm_config_file do
    source 'php-fpm.conf.erb'
    cookbook 'cog_php'
    owner 'root'
    group 'root'
    mode 00644
    variables(pool_config_directory: pool_config_directory,
              pid: pid,
              error_log: error_log,
              log_level: log_level,
              daemonize: daemonize,
              fpm_options: fpm_options)
    notifies :restart, "service[#{service_name}]"
  end

  service service_name do
    action [:enable]
  end

  logrotate_app 'php' do
    cookbook 'logrotate'
    path '/var/log/php-fpm/*.log'
    options %w(missingok compress delaycompress notifempty dateext sharedscripts)
    frequency 'daily'
    rotate 36_500
    postrotate ['/bin/kill -SIGUSR1 `cat /var/run/php-fpm.pid 2>/dev/null` 2>/dev/null || true']
  end
end

action :remove do
  file fpm_config_file do
    action :delete
  end

  php_package fpm_package do
    php_package_options '--enablerepo=webtatic' if node['cog_php']['webtatic-php7'] == true
    action :remove
  end

  logrotate_app 'php' do
    cookbook 'logrotate'
    path '/var/log/php-fpm/*.log'
    options %w(missingok compress delaycompress notifempty dateext sharedscripts)
    frequency 'daily'
    rotate 36_500
    postrotate ['/bin/kill -SIGUSR1 `cat /var/run/php-fpm.pid 2>/dev/null` 2>/dev/null || true']
    action :disable
  end
end
