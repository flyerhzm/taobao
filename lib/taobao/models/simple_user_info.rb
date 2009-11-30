require 'taobao/model'

module Taobao
  class SimpleUserInfo < Model
    def self.elm_name
      "SimpleUserInfo"
    end
    
    def self.attr_names
      [
       :userId,
       :userName
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
