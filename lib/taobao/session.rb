require 'digest/md5'

module Taobao
  class Session
    attr_accessor :session_key

    def initialize(params)
      self.session_key = params['top_session']
    end

    def invoke(method, params)
      Service.new(method, params).invoke
    end

    class InvalidSignature < Exception
    end
  end
end
