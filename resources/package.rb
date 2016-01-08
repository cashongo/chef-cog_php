# generic installer resource
resource_name :php_package

property :php_package_name,     String, name_property: true
property :php_package_options,  String

# local variables
rpm_location = "#{Chef::Config['file_cache_path']}/remi-release-6.rpm"

action :install do
  # remote_file rpm_location do              # prep for remi
  #   source 'http://remi.mirrors.arminco.com/enterprise/remi-release-6.rpm'
  # end
  #
  # rpm_package 'remi-release' do            # prep for remi
  #   source rpm_location
  #   action :install
  # end

  package php_package_name do
    options php_package_options
    action :install
  end

end

action :remove do
  # file rpm_location do                      # prep for remi
  #   action :delete
  # end
  #
  # rpm_package 'remi-release' do             # prep for remi
  #   action :remove
  # end

  package php_package_name do
    action :remove
  end
end
