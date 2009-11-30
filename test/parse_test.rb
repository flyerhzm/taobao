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

    should "process taobao.product.add" do
      # pending
    end

    should "process taobao.product.img.upload" do
      result = Taobao::Parse.new.process(taobao_product_img_upload_xml)
      assert_equal result.size, 1
      assert_equal result[0].pic_id, "5980000"
      assert_equal result[0].url, "http://img05.taobaocdn.com/bao/uploaded/i5/T1WOtoXfJfXXbcaygW_024027.jpg"
    end

    should "process taobao.product.propimg.upload" do
      result = Taobao::Parse.new.process(taobao_product_propimg_upload_xml)
      assert_equal result.size, 1
      assert_equal result[0].pic_id, "5980000"
      assert_equal result[0].url, "http://img05.taobaocdn.com/bao/uploaded/i5/T1WOtoXfJfXXbcaygW_024027.jpg"
      assert_equal result[0].modified, "2009-11-29 14:41:27"
    end

    should "process taobao.product.update" do
      result = Taobao::Parse.new.process(taobao_product_update_xml)
      assert_equal result.size, 1
      assert_equal result[0].product_id, "65879456"
      assert_equal result[0].modified, "2009-11-19 14:55:14"
    end

    should "process taobao.products.get" do
      result = Taobao::Parse.new.process(taobao_products_get_xml)
      assert_equal result.size, 2
      assert_equal result[0].cat_name, "领带夹"
      assert_equal result[0].cid, "50001248"
    end

    should "process taobao.product.img.delete" do
      result = Taobao::Parse.new.process(taobao_product_img_delete_xml)
      assert_equal result.size, 1
      assert_equal result[0].pic_id, "5980085"
      assert_equal result[0].product_id, "66744605"
    end

    should "process taobao.product.propimg.delete" do
      result = Taobao::Parse.new.process(taobao_product_propimg_delete_xml)
      assert_equal result.size, 1
      assert_equal result[0].pic_id, "5980085"
      assert_equal result[0].product_id, "66744605"
    end

    should "process taobao.itempropvalues.get" do
      result = Taobao::Parse.new.process(taobao_itempropvalues_get_xml)
      assert_equal result.size, 3
    end

    should "process taobao.items.get" do
      result = Taobao::Parse.new.process(taobao_items_get_xml)
      assert_equal result.totalResults, "1"
      assert_equal result.size, 1
      assert_equal result[0].iid, "3f9f1794e1100375f3a1e58b64feab73"
      assert_equal result[0].title, "qweqweqweqwe"
      assert_equal result[0].nick, "hz0799"
      assert_equal result[0].type, "fixed"
      assert_equal result[0].cid, "150401"
    end

    should "process taobao.items.search" do
      result = Taobao::Parse.new.process(taobao_items_search_xml)
      assert_equal result.totalResults, "1"
      assert_equal result[0].item_lists.size, 1
      assert_equal result[0].item_lists[0].iid, "3f9f1794e1100375f3a1e58b64feab73"
      assert_equal result[0].category_lists.size, 1
      assert_equal result[0].category_lists[0].category_id, "50010850"
      assert_equal result[0].category_lists[0].count, "12"
    end

    should "process taobao.items.onsale.get" do
      result = Taobao::Parse.new.process(taobao_items_onsale_get_xml)
      assert_equal result.totalResults, "2"
      assert_equal result.size, 2
      assert_equal result[0].iid, "ab1fed8119ba0ab4b66d92cd6be8915a"
    end

    should "process taobao.items.inventory.get" do
      result = Taobao::Parse.new.process(taobao_items_inventory_get_xml)
      assert_equal result.totalResults, "1"
      assert_equal result.size, 1
      assert_equal result[0].iid, "06a1d953a46377d5129cc0ac1308a2ae"
    end

    should "process taobao.items.all.get" do
      result = Taobao::Parse.new.process(taobao_items_all_get_xml)
      assert_equal result.totalResults, "1"
      assert_equal result.size, 1
      assert_equal result[0].iid, "06a1d953a46377d5129cc0ac1308a2ae"
    end

    should "process taobao.item.get" do
      result = Taobao::Parse.new.process(taobao_item_get_xml)
      assert_equal result.size, 1
      assert_equal result[0].iid, "06a1d953a46377d5129cc0ac1308a2ae"
    end

    should "process taobao.taobaoke.items.get" do
      result = Taobao::Parse.new.process(taobao_taobaoke_items_get_xml)
    end

  end

  def taobao_taobaoke_items_get_xml
    <<-XML
    <rsp>
      <taobaokeItem>
        <iid>
          <![CDATA[72b31835f55b6b6c35beab8c753989c1]]>
        </iid>
        <title>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\225\206\345\223\201\345\220\215\347\247\260:1]]>
        </title>
        <pic_url>
          <![CDATA[http://img.taobao.com/bao/uploaded/i2/T1SxBeXg5XMdMUfdMZ_031728.jpg]]>
        </pic_url>
        <price>
          <![CDATA[100]]>
        </price>
        <click_url>
          <![CDATA[http://s.click.alimama.com/ma_a?e=7TbRJUSX6oob60193a32e1ad625]]>
        </click_url>
        <nick>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\215\226\345\256\266\346\230\265\347\247\260:1]]>
        </nick>
      </taobaokeItem>
      <taobaokeItem>
        <iid>
          <![CDATA[72b31835f55b6b6c35beab8c753989c1]]>
        </iid>
        <title>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\225\206\345\223\201\345\220\215\347\247\260:2]]>
        </title>
        <pic_url>
          <![CDATA[http://img.taobao.com/bao/uploaded/i2/T1SxBeXg5XMdMUfdMZ_031728.jpg]]>
        </pic_url>
        <price>
          <![CDATA[100]]>
        </price>
        <click_url>
          <![CDATA[http://s.click.alimama.com/ma_a?e=7TbRJUSX6oob60193a32e1ad625]]>
        </click_url>
        <nick>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\215\226\345\256\266\346\230\265\347\247\260:2]]>
        </nick>
      </taobaokeItem>
      <taobaokeItem>
        <iid>
          <![CDATA[72b31835f55b6b6c35beab8c753989c1]]>
        </iid>
        <title>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\225\206\345\223\201\345\220\215\347\247\260:3]]>
        </title>
        <pic_url>
          <![CDATA[http://img.taobao.com/bao/uploaded/i2/T1SxBeXg5XMdMUfdMZ_031728.jpg]]>
        </pic_url>
        <price>
          <![CDATA[100]]>
        </price>
        <click_url>
          <![CDATA[http://s.click.alimama.com/ma_a?e=7TbRJUSX6oob60193a32e1ad625]]>
        </click_url>
        <nick>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\215\226\345\256\266\346\230\265\347\247\260:3]]>
        </nick>
      </taobaokeItem>
      <taobaokeItem>
        <iid>
          <![CDATA[72b31835f55b6b6c35beab8c753989c1]]>
        </iid>
        <title>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\225\206\345\223\201\345\220\215\347\247\260:4]]>
        </title>
        <pic_url>
          <![CDATA[http://img.taobao.com/bao/uploaded/i2/T1SxBeXg5XMdMUfdMZ_031728.jpg]]>
        </pic_url>
        <price>
          <![CDATA[100]]>
        </price>
        <click_url>
          <![CDATA[http://s.click.alimama.com/ma_a?e=7TbRJUSX6oob60193a32e1ad625]]>
        </click_url>
        <nick>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\215\226\345\256\266\346\230\265\347\247\260:4]]>
        </nick>
      </taobaokeItem>
      <taobaokeItem>
        <iid>
          <![CDATA[72b31835f55b6b6c35beab8c753989c1]]>
        </iid>
        <title>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\225\206\345\223\201\345\220\215\347\247\260:5]]>
        </title>
        <pic_url>
          <![CDATA[http://img.taobao.com/bao/uploaded/i2/T1SxBeXg5XMdMUfdMZ_031728.jpg]]>
        </pic_url>
        <price>
          <![CDATA[100]]>
        </price>
        <click_url>
          <![CDATA[http://s.click.alimama.com/ma_a?e=7TbRJUSX6oob60193a32e1ad625]]>
        </click_url>
        <nick>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\215\226\345\256\266\346\230\265\347\247\260:5]]>
        </nick>
      </taobaokeItem>
      <taobaokeItem>
        <iid>
          <![CDATA[72b31835f55b6b6c35beab8c753989c1]]>
        </iid>
        <title>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\225\206\345\223\201\345\220\215\347\247\260:6]]>
        </title>
        <pic_url>
          <![CDATA[http://img.taobao.com/bao/uploaded/i2/T1SxBeXg5XMdMUfdMZ_031728.jpg]]>
        </pic_url>
        <price>
          <![CDATA[100]]>
        </price>
        <click_url>
          <![CDATA[http://s.click.alimama.com/ma_a?e=7TbRJUSX6oob60193a32e1ad625]]>
        </click_url>
        <nick>
          <![CDATA[\346\267\230\345\256\235\345\256\242\346\265\213\350\257\225\346\225\260\346\215\256\345\215\226\345\256\266\346\230\265\347\247\260:6]]>
        </nick>
      </taobaokeItem>
    </rsp>
    XML
  end

  def taobao_item_get_xml
    <<-XML
    <rsp>
      <item>
        <iid>06a1d953a46377d5129cc0ac1308a2ae</iid>
        <title>链接测试2</title>
        <nick>hz0799</nick>
        <type>fixed</type>
        <cid>50012227</cid>
        <location>
          <city>拉萨</city>
        </location>
        <price>1000.00</price>
        <post_fee>0.00</post_fee>
      </item>
    </rsp>
    XML
  end

  def taobao_items_all_get_xml
    <<-XML
    <rsp>
      <totalResults>1</totalResults>
      <item>
        <iid>06a1d953a46377d5129cc0ac1308a2ae</iid>
        <num_iid>3781986810</num_iid>
        <title>链接测试2</title>
        <nick>hz0799</nick>
        <type>fixed</type>
        <cid>50012227</cid>
        <seller_cids>-1</seller_cids>
        <props>20000:45430;30295:3221642</props>
        <num>1</num>
        <valid_thru>7</valid_thru>
        <price>1000.0</price>
        <has_discount>true</has_discount>
        <has_invoice>false</has_invoice>
        <has_warranty>false</has_warranty>
        <has_showcase>false</has_showcase>
        <modified>2009-11-11 13:15:17</modified>
        <approve_status>other</approve_status>
        <postage_id>0</postage_id>
      </item>
    </rsp>
    XML
  end

  def taobao_items_inventory_get_xml
    <<-XML
    <rsp>
      <totalResults>1</totalResults>
      <item>
        <iid>06a1d953a46377d5129cc0ac1308a2ae</iid>
        <title>链接测试2</title>
        <nick>hz0799</nick>
        <type>fixed</type>
        <cid>50012227</cid>
        <props>20000:45430;30295:3221642</props>
        <num>1</num>
        <valid_thru>7</valid_thru>
        <price>1000.0</price>
        <approve_status>instock</approve_status>
      </item>
    </rsp>
    XML
  end

  def taobao_items_onsale_get_xml
    <<-XML
    <rsp>
      <totalResults>2</totalResults>
      <item>
        <iid>ab1fed8119ba0ab4b66d92cd6be8915a</iid>
        <title>【外婆桥正品】仿藤推车 手推车 宽轮手工推车 藤制推车 测试</title>
        <nick>hz0799</nick>
        <type>fixed</type>
        <cid>50010218</cid>
        <props>20000:8087189;3314686:13202511;3089685:29820073</props>
        <pic_path>http://img08.taobaocdn.com/bao/uploaded/i8/T1RDdfXo8DXXXR8TUZ_033626.jpg</pic_path>
        <num>908</num>
        <valid_thru>7</valid_thru>
        <list_time>2009-11-13 15:39:47</list_time>
        <delist_time>2009-11-20 15:39:47</delist_time>
        <price>50.0</price>
        <approve_status>onsale</approve_status>
      </item>
      <item>
        <iid>711e4b113b9266e0ffbbea34fc09e1ce</iid>
        <title>【外婆桥正品】仿藤推车 手推车 宽轮手工推车 藤制推车 测试</title>
        <nick>hz0799</nick>
        <type>fixed</type>
        <cid>50010218</cid>
        <props>20000:3792546;3089685:90628;3042133:45457</props>
        <pic_path>http://img08.taobaocdn.com/bao/uploaded/i8/T1RDdfXo8DXXXR8TUZ_033626.jpg</pic_path>
        <num>908</num>
        <valid_thru>7</valid_thru>
        <list_time>2009-11-13 15:40:25</list_time>
        <delist_time>2009-11-20 15:40:25</delist_time>
        <price>3560.0</price>
        <approve_status>onsale</approve_status>
      </item>
    </rsp>
    XML
  end

  def taobao_items_search_xml
    <<-XML
    <rsp>
      <totalResults>1</totalResults>
      <itemsearch>
        <item_lists list="true">
          <item_list>
            <iid>3f9f1794e1100375f3a1e58b64feab73</iid>
            <title>qweqweqweqwe</title>
            <nick>hz0799</nick>
            <type>fixed</type>
            <cid>150401</cid>
            <delist_time>2009-11-18 19:32:41</delist_time>
            <location/>
            <price>31.00</price>
            <post_fee>0.00</post_fee>
          </item_list>
        </item_lists>
        <category_lists list="true">
          <category_list>
            <category_id>50010850</category_id>
            <count>12</count>
          </category_list>
        </category_lists>
      </itemsearch>
    </rsp>
    XML
  end

  def taobao_items_get_xml
    <<-XML
    <rsp>
      <totalResults>1</totalResults>
      <item>
        <iid>3f9f1794e1100375f3a1e58b64feab73</iid>
        <title>qweqweqweqwe</title>
        <nick>hz0799</nick>
        <type>fixed</type>
        <cid>150401</cid>
        <delist_time>2009-11-18 19:32:41</delist_time>
        <location/>
        <price>31.00</price>
        <post_fee>0.00</post_fee>
      </item>
    </rsp>
    XML
  end
  def taobao_itempropvalues_get_xml
    <<-XML
    <rsp>
      <lastModified>2009-09-04 14:46:59</lastModified>
      <prop_value>
        <cid>50010527</cid>
        <pid>20000</pid>
        <prop_name>品牌</prop_name>
        <vid>47471</vid>
        <name>Absorba</name>
        <status>normal</status>
        <sort_order>0</sort_order>
      </prop_value>
      <prop_value>
        <cid>50010528</cid>
        <pid>20000</pid>
        <prop_name>品牌</prop_name>
        <vid>45455</vid>
        <name>Carter's</name>
        <status>normal</status>
        <sort_order>0</sort_order>
      </prop_value>
      <prop_value>
        <cid>50010529</cid>
        <pid>20000</pid>
        <prop_name>品牌</prop_name>
        <vid>60353</vid>
        <name>A-爱儿健</name>
        <status>normal</status>
        <sort_order>1</sort_order>
      </prop_value>
    </rsp>
    XML
  end

  def taobao_product_propimg_delete_xml
    <<-XML
    <rsp>
      <ProductPropImg>
        <pic_id>5980085</pic_id>
        <product_id>66744605</product_id>
      </ProductPropImg>
    </rsp>
    XML
  end

  def taobao_product_img_delete_xml
    <<-XML
    <rsp>
      <productImg>
        <pic_id>5980085</pic_id>
        <product_id>66744605</product_id>
      </productImg>
    </rsp>
    XML
  end

  def taobao_products_get_xml
    <<-XML
    <rsp>
      <product>
        <cat_name>领带夹</cat_name>
        <cid>50001248</cid>
        <product_id>66744605</product_id>
        <props>20000:81058;1632501:3233251</props>
        <props_str>品牌:222;货号:123;</props_str>
      </product>
      <product>
        <cat_name>领带夹</cat_name>
        <cid>50001248</cid>
        <product_id>66744448</product_id>
        <props>20000:29527;1632501:3233251</props>
        <props_str>品牌:Uniqlo/优衣库;货号:123;</props_str>
      </product>
    </rsp>
    XML
  end

  def taobao_product_update_xml
    <<-XML
    <rsp>
      <product>
        <modified>2009-11-19 14:55:14</modified>
        <product_id>65879456</product_id>
      </product>
    </rsp>
    XML
  end

  def taobao_product_propimg_upload_xml
    <<-XML
    <rsp>
      <ProductPropImg>
        <pic_id>5980000</pic_id>
        <url>http://img05.taobaocdn.com/bao/uploaded/i5/T1WOtoXfJfXXbcaygW_024027.jpg</url>
        <modified>2009-11-29 14:41:27</modified>
        <created>2009-11-29 14:41:27</created>
      </ProductPropImg>
    </rsp>
    XML
  end

  def taobao_product_img_upload_xml
    <<-XML
    <rsp>
      <productImg>
        <pic_id>5980000</pic_id>
        <url>http://img05.taobaocdn.com/bao/uploaded/i5/T1WOtoXfJfXXbcaygW_024027.jpg</url>
        <modified>2009-11-19 14:41:27</modified>
        <created>2009-11-19 14:41:27</created>
      </productImg>
    </rsp>
    XML
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
            </prop_value>
            <prop_value>
              <vid>10123</vid>
              <name>摩托罗拉</name>
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
