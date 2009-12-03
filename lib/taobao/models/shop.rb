require 'taobao/model'

module Taobao
  class Shop < Model
    def self.elm_name
      "shop"
    end

    def self.attr_names
      [
       :sid,
       :cid,
       :nick,
       :title,
       :desc,
       :bulletin,
       :pic_path,
       :created,
       :modified
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
