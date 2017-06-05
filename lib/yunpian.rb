require 'yunpian/version'
require 'yunpian/request'

module Yunpian
  SEND_GATEWAY    = 'http://yunpian.com/v1/sms/send.json'
  SEND_TPL_GATEWAY= 'http://sms.yunpian.com/v1/sms/tpl_send.json'
  ACCOUNT_GATEWAY = 'http://yunpian.com/v1/user/get.json'

  @timeout = 5

  class << self
    attr_accessor :apikey, :signature, :timeout

    def signature
      @signature.respond_to?(:call) ? @signature.call : @signature
    end

    # 指定模板发送 https://www.yunpian.com/api/sms.html#c8
    #
    # @param recipients [Array, String] 收件人手机号码（或列表）
    # @param tpl_id [Integer] 模板 id
    # @param tpl_params [Hash] 模板参数值
    def send_with_template!(recipients, tpl_id, tpl_params)
      tpl_value = tpl_params.map do |key, value|
        "#{key}=#{value}"
      end.join("&")

      params = {
        apikey: Yunpian.apikey,
        mobile: Array(recipients).join(','),
        tpl_id: tpl_id,
        tpl_value: tpl_value
      }
      Request.new(SEND_TPL_GATEWAY, params).perform!
    end

    def send_with_template(recipients, tpl_id, tpl_params)
      send_with_template!(recipients, tpl_id, tpl_params)
    rescue RequestException
    end

    def send_to(recipients, content, signature = nil)
      params = {
        apikey: Yunpian.apikey,
        mobile: Array(recipients).join(','),
        text:   "#{signature || Yunpian.signature}#{content}"
      }
      Request.new(SEND_GATEWAY, params).perform
    end

    def send_to!(recipients, content, signature = nil)
      params = {
        apikey: Yunpian.apikey,
        mobile: Array(recipients).join(','),
        text:   "#{signature || Yunpian.signature}#{content}"
      }
      Request.new(SEND_GATEWAY, params).perform!
    end

    def account_info
      Request.new(ACCOUNT_GATEWAY, apikey: Yunpian.apikey).perform
    end
  end

  class RequestException < StandardError; end
end
