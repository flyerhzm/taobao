require 'taobao/model'

module Taobao
  class SellerCat < Model
    def self.elm_name
      "seller_cat"
    end
    
    def self.attr_names
      [
       :cid,
       :parent_cid,
       :name,
       :is_parent,
       :nick
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
