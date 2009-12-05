# Include hook code here
taobao_configs = YAML.load_file(File.join(RAILS_ROOT, 'config/taobao.yml'))

ENV['TAOBAO_APP_KEY'] = taobao_configs[RAILS_ENV]['app_key'].to_s
ENV['TAOBAO_APP_SECRET'] = taobao_configs[RAILS_ENV]['app_secret']
ENV['TAOBAO_REST_ENDPOINT'] = taobao_configs[RAILS_ENV]['rest_endpoint']
ENV['TAOBAO_AUTH_URL'] = taobao_configs[RAILS_ENV]['auth_url']

require 'taobao'
