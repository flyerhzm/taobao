require 'taobao/model'

module Taobao
  class ErrorRsp < Error
    def self.elm_name
      "error_rsp"
    end
    
    def push_sym(stack)
    end
  end
end
