#
# http://wiki.open.taobao.com/index.php/ItemSearch
#

require 'taobao/model'

module Taobao
  class ItemSearch < Model
    def self.elm_name
      "itemsearch"
    end

    def self.attr_names
      [
       :item_lists,
       :category_lists
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
