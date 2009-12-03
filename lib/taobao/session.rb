require 'digest/md5'

module Taobao
  class Session
    attr_accessor :session_key
    attr_reader :top_params

    def initialize(params)
      str = params['top_appkey'] + params["top_parameters"] + params["top_session"] + ENV['TAOBAO_APP_SECRET']
      md5 = Digest::MD5.digest(str)
      sign = Base64.encode64(md5).strip

      if sign == params['top_sign']
        self.session_key = params['top_session']
        @top_params = Hash[*(Base64.decode64(params['top_parameters']).split('&').collect {|v| v.split('=')}).flatten]
      else
        throw InvalidSignature.new
      end
    end

    class InvalidSignature < Exception
    end
  end
end
