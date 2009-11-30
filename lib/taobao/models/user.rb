require 'taobao/model'

module Taobao
  class User < Model
    def self.elm_name
      "user"
    end
    
    def self.attr_names
      [
       :id,
       :nick,
       :created,
       :location,
       :sex,
       :buyer_credit,
       :seller_credit,
       :last_visit,
       :real_name,
       :id_card,
       :phone,
       :mobile,
       :email,
       :birthday
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
