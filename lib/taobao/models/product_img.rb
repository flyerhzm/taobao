require 'taobao/model'

module Taobao
  class ProductImg < Model
    def self.elm_name
      "productImg"
    end

    def self.attr_names
      [
       :pic_id,
       :url,
       :position,
       :created,
       :modified,
       :product_id
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
