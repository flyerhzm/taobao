#
# http://wiki.open.taobao.com/index.php/PropValue
#
require 'taobao/model'

module Taobao
  class PropValue < Model
    def self.elm_name
      "prop_value"
    end

    def self.attr_names
      [
       :cid,
       :is_parent,
       :name,
       :name_alias,
       :pid,
       :prop_name,
       :sort_order,
       :status,
       :vid
      ]
    end

    for a in attr_names
      attr_accessor a
    end

  end
end
