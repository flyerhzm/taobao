require 'taobao/model'

module Taobao
  class ProductPropImg < Model
    def self.elm_name
      "productPropImg"
    end

    def self.attr_names
      [
       :pic_id,
       :props,
       :url,
       :position
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
