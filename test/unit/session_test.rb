require "#{File.dirname(__FILE__)}/../test_helper"
require "taobao/session"

ENV['TAOBAO_APP_KEY'] = '12017774'
ENV['TAOBAO_APP_SECRET'] = '42ab2d12a5bea25d1bc06ccde9861daf'

class SessionTest < ActiveSupport::TestCase
  context "Initialize the session" do

    setup do
      @params = {
        "top_sign"=>"9QB/6rEAwejVibFh7SKg4w==",
        "top_session"=>"11b9860d823d2add3e3643ffb8610563c",
        "top_parameters"=>"aWZyYW1lPTEmdHM9MTI1OTY1MTUwMzg0OCZ2aWV3X21vZGU9ZnVsbCZ2aWV3X3dpZHRoPTAmdmlzaXRvcl9pZD0xNzU3NTQzNTEmdmlzaXRvcl9uaWNrPWFsaXB1YmxpYzAx",
        "top_appkey"=>"12017774"
      }
    end

    should "get the session_key and top_params from the params hash" do
      assert_nothing_raised do
        @session = Taobao::Session.new @params
      end
      assert_not_nil @session.session_key
      assert_not_nil @session.top_params
      assert_equal @session.top_params['visitor_nick'], "alipublic01"
      assert_equal @session.top_params['visitor_id'], "175754351"
      assert_equal @session.top_params['view_width'], "0"
      assert_equal @session.top_params['iframe'], "1"
      assert_equal @session.top_params['view_mode'], "full"
      assert_equal @session.top_params['ts'], "1259651503848"
    end
  end
end
