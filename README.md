# deploykey-cookbook

Chef custom resource to distribute deployment keys.

Roadmap:
- encapsulate optional use of chef-vault

## Supported Platforms

- linux

## Usage

    deploykey 'name_of_key' do
      key_location '/path/to/directory'       # will be merged with 'name_of_key'
      key_content  'key content'
      user          'user name'
      action :create, :delete
    end

### deploykey::default

Include `deploykey` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[deploykey::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)
