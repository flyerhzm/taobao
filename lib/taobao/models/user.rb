require 'taobao/model'

module Taobao
  class User < Model
    def self.elm_name
      "user"
    end

    def self.attr_names
      [
       :alipay_bind,
       :auto_repost,
       :birthday,
       :buyer_credit,
       :consumer_protection,
       :created,
       :has_more_pic,
       :item_img_num,
       :item_img_size,
       :last_visit,
       :location,
       :nick,
       :promoted_type,
       :prop_img_num,
       :prop_img_size,
       :seller_credit,
       :sex,
       :status,
       :type,
       :user_id
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
