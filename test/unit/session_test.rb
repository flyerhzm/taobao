require "#{File.dirname(__FILE__)}/../test_helper"
require "taobao/session"

ENV['TAOBAO_APP_KEY'] = '12017774'
ENV['TAOBAO_APP_SECRET'] = '42ab2d12a5bea25d1bc06ccde9861daf'

class SessionTest < ActiveSupport::TestCase
  context "Initialize the session" do

    setup do
      @params = {
        "top_sign"=>"utdqxA9WSBp7tuRSnFMrOw==",
        "top_session"=>"1b91f79ea622dc2f738c3152b485584f1",
        "top_parameters"=>"aWZyYW1lPTEmdHM9MTI1OTYzNDY2MDI0OSZ2aWV3X21vZGU9ZnVsbCZ2aWV3X3dpZHRoPTAmdmlzaXRvcl9pZD0xNzU5NzgyNjkmdmlzaXRvcl9uaWNrPXNhbmRib3hfY18x",
        "top_appkey"=>"12017774"
      }
    end

    should "get the parameter information from the params hash" do
      assert_nothing_raised do
        Taobao::Session.new @params
      end
    end
  end
end
