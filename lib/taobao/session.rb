require 'digest/md5'

module Taobao
  class Session
    attr_accessor :session_key

    def initialize(params)
      str = params.sort.collect { |c| c[0] != 'top_sign' ? "#{c[1]}" : ""}.join("") +  ENV['TAOBAO_APP_SECRET']
      sign = Base64.encode64(Digest::MD5.hexdigest(str).upcase!)

      self.session_key = params[:top_session]

      # if sign == params[:top_sign]
      #   self.session_key = params[:top_session]
      # else
      #   throw InvalidSignature.new
      # end
    end

    class InvalidSignature < Exception
    end
  end
end
