resource_name :php_fpm_pool

property :pool_name, String, name_property: true
property :config_file, String, required: true
property :pool_config_directory, String, default: '/etc/php-fpm.d'
property :service_name, String, default: 'php-fpm'
property :process_manager, String, default: 'ondemand'
property :pool_user, String
property :pool_group, String
property :listen, String
property :allowed_clients, String
property :max_children, Integer, default: 5
property :start_servers, Integer, default: 1
property :min_spare_servers, Integer, default: 1
property :max_spare_servers, Integer, default: 1
property :max_requests, Integer, default:  500
property :pm_status_path, String, default: '/status'
property :ping_path, String, default: '/ping'
property :ping_response, String, default: 'pong'
property :catch_workers_output, String, default: 'no'
property :pool_options, Hash

action :create do
  template config_file do
    path(pool_config_directory + '/' + config_file)
    source 'php-fpm_pool.conf.erb'
    cookbook 'cog_php'
    owner 'root'
    group 'root'
    mode 00644
    variables(
      pool_name: pool_name,
      process_manager: process_manager,
      pool_user: pool_user,
      pool_group: pool_group,
      listen: listen,
      allowed_clients: allowed_clients,
      max_children: max_children,
      start_servers: start_servers,
      min_spare_servers: min_spare_servers,
      max_spare_servers: max_spare_servers,
      max_requests: max_requests,
      pm_status_path: pm_status_path,
      ping_path: ping_path,
      ping_response: ping_response,
      catch_workers_output: catch_workers_output,
      pool_options: pool_options
    )
    notifies :restart, "service[#{service_name}]"
  end

  service service_name do
    action [:enable]
  end
end

action :remove do
  file config_file do
    path(pool_config_directory + '/' + config_file)
    action :delete
  end
end
