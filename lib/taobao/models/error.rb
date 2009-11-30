require 'taobao/model'

module Taobao
  class Error < Model
    def self.elm_name
      "error"
    end
    
    def self.attr_names
      [
       :msg,
       :code
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

    def push_sym(stack)
      stack.push(:msg=)
    end
  end
end
