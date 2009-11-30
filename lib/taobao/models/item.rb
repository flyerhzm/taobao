require 'taobao/model'

module Taobao
  class Item < Model
    def self.elm_name
      "item"
    end

    def self.attr_names
      [
       :approve_status,
       :auction_point,
       :auto_repost,
       :cid,
       :delist_time,
       :desc,
       :detail_url,
       :ems_fee,
       :express_fee,
       :freight_payer,
       :has_discount,
       :has_invoice,
       :has_showcase,
       :has_warranty,
       :iid,
       :increment,
       :input_pids,
       :input_str,
       :is_3D,
       :is_ex,
       :is_taobao,
       :is_virtural,
       :list_time,
       :location,
       :modified,
       :nick,
       :num,
       :num_iid,
       :outer_id,
       :pic_path,
       :post_fee,
       :postage_id,
       :price,
       :product_id,
       :property_alias,
       :props,
       :score,
       :seller_cids,
       :stuff_status,
       :title,
       :type,
       :valid_thru,
       :volume
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
