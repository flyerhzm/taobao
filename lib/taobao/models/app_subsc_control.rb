require 'taobao/model'

module Taobao
  class AppSubscControl < Model
    def self.elm_name
      "AppSubscControl"
    end
    
    def self.attr_names
      [
       :appId,
       :appInstanceId,
       :userCount,
       :gmtStart,
       :gmtEnd,
       :ctrlParams
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
