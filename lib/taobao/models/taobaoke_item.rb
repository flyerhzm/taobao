#
# http://wiki.open.taobao.com/index.php/TaobaokeItem
#

require 'taobao/model'

module Taobao
  class TaobaokeItem < Model
    def self.elm_name
      "taobaokeItem"
    end

    def self.attr_names
      [
       :click_url,
       :commission,
       :commission_num,
       :commission_rate,
       :commission_volume,
       :iid,
       :nick,
       :pic_url,
       :price,
       :title
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
