require 'taobao/model'

module Taobao
  class ItemCat < Model
    def self.elm_name
      "item_cat"
    end
    
    def self.attr_names
      [
       :cid,
       :parent_cid,
       :name,
       :is_parent
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
