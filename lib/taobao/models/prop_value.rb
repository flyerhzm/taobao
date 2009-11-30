require 'taobao/model'

module Taobao
  class PropValue < Model
    def self.elm_name
      "prop_value"
    end
    
    def self.attr_names
      [
       :vid,
       :name,
       :child_pid,
       :binds
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
