require 'taobao/model'

module Taobao
  class Trade < Model
    def self.elm_name
      "trade"
    end
    
    def self.attr_names
      [
       :seller_nick,
       :buyer_nick,
       :iid,
       :title,
       :price,
       :pic_path,
       :num,
       :created,
       :type,
       :tid,
       :status,
       :seller_rate,
       :buyer_rate
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
