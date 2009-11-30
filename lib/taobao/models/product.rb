require 'taobao/model'

module Taobao
  class Product < Model
    def self.elm_name
      "product"
    end

    def self.attr_names
      [
       :product_id,
       :outer_id,
       :tsc,
       :cid,
       :cat_name,
       :props,
       :props_str,
       :name,
       :binds,
       :binds_str,
       :sale_props,
       :sale_props_str,
       :price,
       :desc,
       :pic_path,
       :created,
       :modified,
       :product_imgs
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
