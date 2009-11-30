require 'taobao/model'

module Taobao
  class Item < Model
    def self.elm_name
      "item"
    end
    
    def self.attr_names
      [
       :iid,
       :title,
       :nick,
       :type,
       :cid,
       :seller_cids,
       :props,
       :desc,
       :pic_path,
       :num,
       :valid_thru,
       :list_time,
       :delist_time,
       :stuff_status,
       :location,
       :price,
       :post_fee,
       :express_fee,
       :ems_fee,
       :pay_type,
       :has_discount,
       :freight_payer,
       :has_invoice,
       :has_warranty,
       :has_alipay,
       :has_showcase,
       :bulk_base_num,
       :modified,
       :increment,
       :auto_repost,
       :approve_status
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
