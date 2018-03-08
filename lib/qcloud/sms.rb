require "qcloud/sms/version"
require 'digest'
require 'typhoeus/adapters/faraday'

module Qcloud
  module Sms
    class Configuration
      attr_accessor :app_id, :app_key, :sign, :tpl_id
      def initialize
        @app_id = ''
        @app_key = ''
        @sign = ''
        @tpl_id = ''
      end
    end

    class << self
      attr_writer :configuration

      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def sms_single_sender(mobile, templId, params)
        Typhoeus.post("https://yun.tim.qq.com/v5/tlssmssvr/?" + "sdkappid=" + configuration.app_id + "&random=" + random,
                 headers: {'Content-Type'=> "application/json"},
                 body: post_body_data(mobile, templId, params))
      end

      # 生成数字签名
      def sig(mobile)
        key = key_secret + '&'
        signature = 'appkey=' + configuration.app_key + "&random=" + random + "&time=" + seed_timestamp + "&mobile=" + mobile
        Digest::SHA256.hexdigest signature
      end

      # 生成随机数
      def random
        SecureRandom.random_number.to_s.slice(-6..-1)
      end

      # 组成附带签名的 POST 方法的 BODY 请求字符串
      def post_body_data(mobile, templId, params)
        body_data = {
          params: params,
          sig: sig(mobile),
          sign: configuration.sign,
          tel: {
            mobile: mobile,
            nationcode: "86"
          },
          time: seed_timestamp,
          tpl_id: templId
          extend: "",
          ext: ""
        }
      }
      end

      # 生成短信时间戳
      def seed_timestamp
        Time.now.to_i
      end

    end
  end
end
