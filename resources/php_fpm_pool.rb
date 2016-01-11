resource_name :php_fpm_pool

property :pool_name,          String, name_property: true
property :fpm_package,        String
property :config_file,        String
property :config_path,        String
property :service_name,       String
property :process_manager,    String
property :user,               String
property :group,              String
property :listen,             String
property :allowed_clients,    String
property :max_children,       String
property :start_servers,      String
property :min_spare_servers,  String
property :max_spare_servers,  String
property :max_requests,       String
property :pm_status_path,     String
property :ping_path,          String
property :php_options,        Hash

action :create do
  php_package fpm_package do
    # php_package_options '--enablerepo=epel'               # prep for remi
    action :install
  end

  template config_file do
    path      config_path
    source    'php-fpm_pool.conf.erb'
    owner     'root'
    group     'root'
    mode      00644
    variables(
      :pool_name            => pool_name,
      :listen               => listen,
      :allowed_clients      => allowed_clients,
      :user                 => user,
      :group                => group,
      :process_manager      => process_manager,
      :max_children         => max_children,
      :start_servers        => start_servers,
      :min_spare_servers    => min_spare_servers,
      :max_spare_servers    => max_spare_servers,
      :max_requests         => max_requests,
      :catch_workers_output => catch_workers_output,
      :pm_status_path       => pm_status_path,
      :ping_path            => ping_path,
      :ping_response        => ping_response,
      :php_options          => php_options
    )
    notifies :restart, "service[#{service_name}]"
  end

  file 'www.conf' do
    path      config_path
    action    :delete
    notifies  :restart, "service[#{service_name}]"
  end

  service service_name do
    action [ :enable ]
  end
end

action :remove do
  file config_file do
    path    config_path
    action  :delete
  end
end
