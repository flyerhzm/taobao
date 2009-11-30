# -*- coding: utf-8 -*-
require 'test_helper'
require "taobao/parse"

require 'pp'

class ParseTest < Test::Unit::TestCase
  context "A Parser instance" do

    should "should parse the error xml" do
      result = Taobao::Parse.new.process(error_xml)
      assert_equal result, "error_message"
    end

    should "should parse normal response xml" do
      result = Taobao::Parse.new.process(normal_response_xml)
      assert_equal result, "0"
    end

    should "should parse simple user info xml" do
      result = Taobao::Parse.new.process(simple_user_info_xml)
      assert_equal result.size,1
      assert_equal result.last.userId, "111"
      assert_equal result.last.userName, "111"
    end

    should "should parse app subsc control xml" do
      result = Taobao::Parse.new.process(app_subsc_control_xml)
      assert_equal result.appId, "22"
      assert_equal result.appInstanceId, "paninstance001"
      assert_equal result.userCount, "115"
      assert_equal result.gmtStart, "2007-11-01 00:00:00.0 CST"
      assert_equal result.gmtEnd, "2007-11-11 00:00:00.0 CST"
      assert_equal result.ctrlParams, 'm=1&t=df'
    end

    should "should parse return from taobao.users.get" do
      result = Taobao::Parse.new.process(users_get_xml)
    end

    should "should handle error_rsp" do
      result = Taobao::Parse.new.process(error_rsp_xml)
      assert_equal result.code, "11"
      assert_equal result.msg, "error-message"
    end

    should "should handle item_cat" do
      result = Taobao::Parse.new.process(item_cats_xml)
      assert_equal result.size, 2
      assert_equal result.first.cid, "11"
      assert_equal result.first.name, "电脑硬件/台式整机/网络设备"
    end

    should "should handle seller_cat" do
      result = Taobao::Parse.new.process(seller_cats_xml)
      assert_equal result.size, 3
    end

    should "should handle item_props" do
      result = Taobao::Parse.new.process(item_props_xml)
      assert_equal result.size, 3
      assert_equal result[0].prop_values.size, 2
      assert_equal result[1].prop_values.size, 2
      assert_equal result[2].prop_values.size, 2
    end

    should "should handle item_prop with prop_values" do
      result = Taobao::Parse.new.process(item_prop_xml)
      assert_equal result.pid, "20879"
      assert_equal result.name, "成色"
      assert_equal result.must, "true"
      assert_equal result.prop_values.size, 1
      assert_equal result.prop_values[0].vid, "32559"
      assert_equal result.prop_values[0].name, "9成新"
    end

    should "should handle items" do
      result = Taobao::Parse.new.process(items_xml)
      assert_equal result.size, 2
      assert_equal result[0].title, "nokia8210"
      assert_equal result[0].price, "500.00"
    end

    should "should handle trades" do
      result = Taobao::Parse.new.process(trades_xml)
      assert_equal result.size, 2
    end

    should "parse taobao.user.get" do
      result = Taobao::Parse.new.process(taobao_user_get_xml)
      assert_equal result[0].buyer_credit.level, "0"
      assert_equal result[0].nick, "nick"
      assert_equal result[0].location.city, "金华"
    end

    should "parse taobao.users.get" do
      result = Taobao::Parse.new.process(taobao_users_get_xml)
      assert_equal result.size,2
      assert_equal result[1].buyer_credit.level, "0"
      assert_equal result[1].nick, "nick"
      assert_equal result[1].location.city, "金华"
      assert_equal result[0].buyer_credit.level, "4"
      assert_equal result[0].nick, "hz0799"
      assert_equal result[0].location.city, "新界"
    end

    should "parse taobao.product.get" do
      result = Taobao::Parse.new.process(taobao_product_get_xml)
      assert_equal result.size, 1
      assert_equal result[0].cat_name, "手机"
      assert_equal result[0].cid, "1512"
      assert_equal result[0].name, "测试手机"
      assert_equal result[0].product_id, "1895913"
      assert_equal result[0].product_imgs.size, 1
      assert_equal result[0].props, "20000:10552;32222:10555"
      assert_equal result[0].props_str, "品牌:松下;松下型号:MX7;"
    end

    should "parse taobao.products.search" do
      result = Taobao::Parse.new.process(taobao_products_search_xml)
      assert_equal result.size, 2
      assert_equal result.totalResults, "17378"
      assert_equal result[0].cid, "50012028"
      assert_equal result[0].price, "168.00"
      assert_equal result[1].name, "嘉士厨13CM保鲜碗"
    end

  end

  def taobao_products_search_xml
    <<-XML
    <rsp>
      <totalResults>17378</totalResults>
      <product>
        <cid>50012028</cid>
        <name>包邮[w13-626]arishop杂志推荐两穿前系带尖头平跟短筒雪地靴子</name>
        <price>168.00</price>
        <product_id>68698103</product_id>
        <props>20000:6649760;1632501:41643078</props>
        <tsc>DCRLUC</tsc>
      </product>
      <product>
        <cid>50000567</cid>
        <name>嘉士厨13CM保鲜碗</name>
        <price>28.00</price>
        <product_id>68695959</product_id>
        <props>20000:40711303;1632501:41642217</props>
        <tsc>JHTLUC</tsc>
      </product>
    </rsp>
    XML
  end

  def taobao_product_get_xml
    <<-XML
    <rsp>
      <product>
        <cat_name>手机</cat_name>
        <cid>1512</cid>
        <name>测试手机</name>
        <product_id>1895913</product_id>
        <product_imgs list="true">
          <productImg />
        </product_imgs>
        <props>20000:10552;32222:10555</props>
        <props_str>品牌:松下;松下型号:MX7;</props_str>
      </product>
    </rsp>
    XML
  end

  def trades_xml
    <<-XML
      <rsp>
        <trade>
          <buyer_nick>zizaitest10017</buyer_nick>
          <created>2008-03-07 14:45:29</created>
        </trade>
        <trade>
          <buyer_nick>zizaitest10017</buyer_nick>
          <created>2008-03-07 14:45:07</created>
        </trade>
      </rsp>
    XML
  end

  def items_xml
    <<-XML
      <?xml version="1.0" encoding="utf-8" ?>
      <rsp>
        <item>
          <title>nokia8210</title>
          <price>500.00</price>
        </item>
        <item>
          <title>nokia7610</title>
          <price>800.00</price>
        </item>
      </rsp>
    XML
  end

  def item_prop_xml
    <<-XML
      <item_prop>
        <pid>20879</pid>
        <name>成色</name>
        <must>true</must>
        <prop_values>
          <prop_value>
            <vid>32559</vid>
            <name>9成新</name>
          </prop_value>
        </prop_values>
      </item_prop>
    XML
  end
  def item_props_xml
    <<-XML
      <?xml version="1.0" encoding="utf-8"?>
      <rsp>
        <item_prop>
          <pid>20879</pid>
          <name>成色</name>
          <must>true</must>
          <prop_values>
            <prop_value>
              <vid>32559</vid>
              <name>9成新</name>
            </prop_value>
            <prop_value>
              <vid>32557</vid>
              <name>9.9成新</name>
            </prop_value>
          </prop_values>
        </item_prop>
        <item_prop>
          <pid>10005</pid>
          <name>品牌</name>
          <must>true</must>
          <prop_values>
            <prop_value>
              <vid>10027</vid>
              <name>诺基亚</name>
              <child_pid>10006</child_pid>
            </prop_value>
            <prop_value>
              <vid>10123</vid>
              <name>摩托罗拉</name>
              <child_pid>10007</child_pid>
            </prop_value>
          </prop_values>
        </item_prop>
        <item_prop>
          <pid>21514</pid>
          <name>手机价格区间</name>
          <prop_values>
            <prop_value>
              <vid>42370</vid>
              <name>1000元以下</name>
            </prop_value>
            <prop_value>
              <vid>38489</vid>
              <name>1001-2000元</name>
            </prop_value>
          </prop_values>
        </item_prop>
      </rsp>
    XML
  end

  def seller_cats_xml
    <<-XML
      <?xml version="1.0" encoding="utf-8" ?>
      <rsp>
        <seller_cat>
          <cid>1114627</cid>
          <parent_cid>0</parent_cid>
          <name>a</name>
        </seller_cat>
        <seller_cat>
          <cid>1114629</cid>
          <parent_cid>1114627</parent_cid>
          <name>bb</name>
        </seller_cat>
        <seller_cat>
          <cid>1114628</cid>
          <parent_cid>0</parent_cid>
          <name>bcdaaa</name>
        </seller_cat>
      </rsp>
    XML
  end

  def item_cats_xml
    <<-XML
      <?xml version="1.0" encoding="utf-8" ?>
      <rsp>
        <item_cat>
          <cid>11</cid>
          <name>电脑硬件/台式整机/网络设备</name>
        </item_cat>
        <item_cat>
          <cid>1512</cid>
          <name>手机</name>
          <is_parent>true</is_parent>
        </item_cat>
      </rsp>
    XML
  end
  def error_rsp_xml
    <<-XML
      <?xml version="1.0" encoding="utf-8" ?>
      <error_rsp>
        <code>11</code>
        <msg>error-message</msg>
      </error_rsp>
    XML
  end

  def users_get_xml
    <<-XML
      <?xml version="1.0" encoding="utf-8" ?>
      <rsp>
        <user>
          <id>3243554</id>
          <nick>alin</nick>
          <created>2006-01-04 12:34:56</created>
          <location>
            <city>杭州</city>
          </location>
        </user>
        <user>
          <id>3243554</id>
          <nick>yy</nick>
          <created>2006-01-04 12:34:56</created>
          <location>
            <city>杭州</city>
          </location>
        </user>
      </rsp>
    XML
  end

  def error_xml
    <<-XML
      <?xml version="1.0" encoding="utf-8" ?>
      <error>error_message</error>
    XML
  end

  def normal_response_xml
    <<-XML
    <?xml version="1.0" encoding="utf-8" ?>
    <String>0</String>
    XML
  end

  def simple_user_info_xml
    <<-XML
    <?xml version="1.0" encoding="utf-8" ?>
    <SimpleUserInfo-array>
      <SimpleUserInfo>
        <userId>111</userId>
        <userName>111</userName>
      </SimpleUserInfo>
    </SimpleUserInfo-array>
    XML
  end

  def app_subsc_control_xml
    <<-XML
      <?xml version="1.0" encoding="utf-8" ?>
      <AppSubscControl>
        <appId>22</appId>
        <appInstanceId>paninstance001</appInstanceId>
        <userCount>115</userCount>
        <gmtStart>2007-11-01 00:00:00.0 CST</gmtStart>
        <gmtEnd>2007-11-11 00:00:00.0 CST</gmtEnd>
        <ctrlParams>m=1&t=df</ctrlParams>
      </AppSubscControl>
    XML
  end

  def taobao_user_get_xml
    <<-XML
    <rsp>
      <user>
        <buyer_credit>
          <level>0</level>
          <score>0</score>
          <total_num>0</total_num>
          <good_num>0</good_num>
        </buyer_credit>
        <created>2003-10-30 15:46:36</created>
        <last_visit>1970-01-01 00:00:00</last_visit>
        <location>
          <city>金华</city>
          <state>浙江</state>
        </location>
        <nick>nick</nick>
        <seller_credit>
          <level>0</level>
          <score>0</score>
          <total_num>0</total_num>
          <good_num>0</good_num>
        </seller_credit>
      </user>

    </rsp>
    XML
  end

  def taobao_users_get_xml
    <<-XML
    <rsp>
      <user>
        <buyer_credit>
          <level>4</level>
          <score>147</score>
          <total_num>147</total_num>
          <good_num>147</good_num>
        </buyer_credit>
        <created>2005-02-17 13:19:49</created>
        <last_visit>2009-11-06 14:39:24</last_visit>
        <location>
          <city>新界</city>
          <state>香港</state>
        </location>
        <nick>hz0799</nick>
        <seller_credit>
          <level>4</level>
          <score>146</score>
          <total_num>156</total_num>
          <good_num>150</good_num>
        </seller_credit>
        <sex>m</sex>
      </user>
      <user>
        <buyer_credit>
          <level>0</level>
          <score>0</score>
          <total_num>0</total_num>
          <good_num>0</good_num>
        </buyer_credit>
        <created>2003-10-30 15:46:36</created>
        <last_visit>1970-01-01 00:00:00</last_visit>
        <location>
          <city>金华</city>
          <state>浙江</state>
        </location>
        <nick>nick</nick>
        <seller_credit>
          <level>0</level>
          <score>0</score>
          <total_num>0</total_num>
          <good_num>0</good_num>
        </seller_credit>
      </user>

    </rsp>
    XML
  end
end
