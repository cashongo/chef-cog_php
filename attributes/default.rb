# Amazon Linux php.ini adjustments to compiled defaults
default['cog_php']['webtatic-php7'] = false

default['cog_php']['php_ini'] = {
  'display_errors' => 'Off',
  'enable_dl' => 'Off',
  'error_reporting' => "E_ALL & ~E_NOTICE",
  'log_errors' => 'On',
  'mail.add_x_header' => 'On',
  'request_order' => 'GP',
  'sendmail_path' => '\'/usr/sbin/sendmail -t -i\'',
  'short_open_tag' => 'Off',
  'variables_order' => '\'GPCS\'',
  'session.gc_divisor' => 1000,
  'session.hash_bits_per_character' => 5,
  'always_populate_raw_post_data' => -1,
  'url_rewriter.tags' => '\'a=href,area=href,frame=src,input=src,form=fakeentry\''
}
