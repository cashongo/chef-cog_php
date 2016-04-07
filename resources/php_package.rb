# generic installer resource
resource_name :php_package

property :php_package_name, String, name_property: true
property :php_package_options, String

action :install do
  if node['cog_php']['webtatic-php7'] == true
    rpm_location = "#{Chef::Config['file_cache_path']}/webtatic-release.rpm"
    remote_file rpm_location do
      source 'https://mirror.webtatic.com/yum/el6/latest.rpm'
    end

    rpm_package 'webtatic-release' do
      source rpm_location
      action :install
    end
  end

  package php_package_name do
    options php_package_options
    action :install
  end
end

action :remove do
  if node['cog_php']['webtatic-php7'] == true
    file rpm_location do
      action :delete
    end

    rpm_package 'webtatic-release' do
      action :remove
    end
  end

  package php_package_name do
    action :remove
  end
end
