# generic installer resource
resource_name :php_package

property :php_package_name, String, name_property: true
property :php_package_options, String

action :install do
  package php_package_name do
    options php_package_options
    action :install
  end
end

action :remove do
  package php_package_name do
    action :remove
  end
end
