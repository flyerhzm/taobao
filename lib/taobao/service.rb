module Taobao
  class Service
    def initialize(method, options={})
      options = options.clone

      @params = {
        'app_key'=>'test',
        'method'=>'taobao.taobaoke.items.get',
        'format'=>'xml',
        'v'=>'1.0',
        'timestamp'=>t.strftime("%Y-%m-%d %H:%M:%S"),
        'fields'=>'iid,title,nick,pic_url,price,click_url',
        'pid' => 'mm_5410_0_0',
        'cid' => '1512',
        'page_no' => '1',
        'page_size' => '6'
      }

      @params = {}
      @params["appId"] = options.delete("app_id")
      @params["sip_apiname"] = method
      @params["sip_appkey"] = ENV['ALISOFT_SIP_APPKEY']
      @params["sip_timestamp"] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      @params["userId"] = options.delete('user_id')
      @params["appInstanceId"] = options.delete('app_instance_id')
      @params.merge!(options)
      str = ENV['ALISOFT_SIP_CERT_CODE'] + (@params.sort.collect { |c| "#{c[0]}#{c[1]}" }).join("")
      @params["sip_sign"] = Digest::MD5.hexdigest(str).upcase!
    end

    def invoke
      print "invoking service at #{ENV['ALISOFT_REST_ENDPOINT']} with #{@params.inspect}\n"
      res = Net::HTTP.post_form(URI.parse(ENV['ALISOFT_REST_ENDPOINT']), @params)
      print "return #{res.inspect} --- #{res.body.inspect}\n"
      Parse.new.process(res.body)
    end
  end
end
