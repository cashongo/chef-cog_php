# manages additional repositories
resource_name :php_repo

property :repo, String, name_property: true

action :install do
  if repo == 'webtatic-php7'
    rpm_location = "#{Chef::Config['file_cache_path']}/webtatic-release.rpm"
    remote_file rpm_location do
      source 'https://mirror.webtatic.com/yum/el6/latest.rpm'
    end

    rpm_package 'webtatic-release' do
      source rpm_location
      action :install
    end
  end
end

action :remove do
  if repo == 'webtatic-php7'
    rpm_location = "#{Chef::Config['file_cache_path']}/webtatic-release.rpm"
    file rpm_location do
      action :delete
    end

    rpm_package 'webtatic-release' do
      action :remove
    end
  end
end
