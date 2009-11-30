require 'taobao/model'

module Taobao
  class UserCredit < Model
    def self.elm_name
      "UserCredit"
    end
    
    def self.attr_names
      [
       :level,
       :score,
       :total_num,
       :good_num
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
