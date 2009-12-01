module Taobao
  module Rails
    module Controller

      def self.included(base)
        base.extend(ClassMethods)
      end

      def taobao_session
        session[:taobao_session]
      end

      def set_taobao_session
        if params[:top_session]

        end
      end

      def taobao_auth_link(name)
        link_to name, "http://open.taobao.com/isv/authorize.php?appkey=#{ENV['TAOBAO_APP_KEY']}"
      end

      module ClassMethods
        def ensure_taobao_authentication(options = {})
          before_filter :ensure_taobao_authentication, options
        end
      end
    end
  end
end

