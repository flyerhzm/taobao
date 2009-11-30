require 'taobao/model'

module Taobao
  class ItemProp < Model
    def self.elm_name
      "item_prop"
    end
    
    def self.attr_names
      [
       :pid,
       :name,
       :must,
       :multi,
       :prop_values
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
