require 'taobao/model'

module Taobao
  class Location < Model
    def self.elm_name
      "location"
    end
    
    def self.attr_names
      [
       :zip,
       :address,
       :city,
       :state,
       :country
      ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
