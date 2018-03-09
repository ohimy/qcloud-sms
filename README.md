# Qcloud::Sms 腾讯云短信服务 Ruby Gem qcloud-sms

## 特别说明

由于第一次提交gem，很多地方不完善，等有时间补习下功课了再逐步完善相关功能。

## 使用说明

用于腾讯云短信服务的 Ruby Gem. 使用这个 Gem 的前提是已经在腾讯云注册用户，申请开通了短信服务，
并获得了以下几个关键参数：

1. app\_id：        腾讯云接入ID，在腾讯云控制台申请获取。
2. app\_key：       腾讯云接入密钥， 在腾讯云控制台申请获取。
3. sign：           短信签名，在腾讯云申请开通短信服务时获取。

## Installation 安装

### Ruby 通用安装方法
在命令行中输入命令（电脑已经安装 gems 命令行工具）

```ruby
gem install qcloud-sms
```

### Rails 应用安装方法

在应用的 Gemfile 文件中添加 Ruby Gems 安装源:

```ruby
gem 'qcloud-sms'   # Ruby Gems 安装源
```

应用的根目录下运行:

```ruby
bundle
```

### 安装可能遇到的问题及其解决方式  

安装后，如果在 irb 命令行输入下面命令后，无法正确获取 Gem 引用，

```ruby
require 'qcloud/sms'
```

或者，在 Rails 启动时报错提示如下：

> ./config/initializers/qcloud-sms.rb:1:in `<top (required)>': uninitialized constant Qcloud::Sms (NameError)

很可能是镜像安装源与 Ruby Gems 不同步造成的，可以改为 Github 安装源，例如 Rails Gemfile 文件引用可以改为下面格式，即可正确安装。

```ruby
gem 'qcloud-sms', git: 'https://github.com/ohimy/qcloud-sms.git'
```

## Usage 使用

### Ruby 程序通用方法

#### 第一步：

    $ require 'qcloud/sms'

#### 第二步：

参数设置：

    $ Qcloud::Sms.configure do |config|
          config.app_id = APP_ID         # 腾讯云接入ID，在腾讯云控制台申请
          config.app_key = APP_KEY       # 腾讯云接入密钥, 在腾讯云控制台申请
          config.sign = 'OHIMY中国'       # 默认设置，如果没有特殊需要，可以不改
      end

#### 第三步：

发送短信：

    $ Qcloud::Sms.single_sender(phone_number, template_code, params)

参数说明：

1. phone_number: 接收短信的手机号，必须为字符型，例如 '1234567890'；
2. template\_code: 短信模版代码，必须为数字型，申请开通短信服务后，由腾讯云提供，例如 '12345678'；
3. params: 请求字符串，向短信模版提供参数，必须为数组型，例如 '["params1", "params2"]'。

### Rails 应用使用方法

#### 第一步：

在 Rails 应用目录 config/initializers/ 下创建脚本文件 qcloud-sms.rb，在文件中加入以下内容：

config/initializers/qcloud-sms.rb

```ruby
Qcloud::Sms.configure do |config|
    config.app_id = APP_ID         # 腾讯云接入ID，在腾讯云控制台申请
    config.app_key = APP_KEY       # 腾讯云接入密钥, 在腾讯云控制台申请
    config.sign = 'OHIMY中国'
  end
```

#### 第二步：

在 Rails 应用中调用短信发送代码：

```ruby
Qcloud::Sms.single_sender(phone_number, template_code, params)
```    

参数说明：

1. phone_number: 接收短信的手机号，必须为字符型，例如 '1234567890'；
2. template\_code: 短信模版代码，必须为数字型，申请开通短信服务后，由腾讯云提供，例如 '12345678'；
3. params: 请求字符串，向短信模版提供参数，必须为数组型，例如 '["params1", "params2"]'。


```ruby
...
phone_number = '1234567890'
template_code = 12345678
params = ["params1", "params2"]
Qcloud::Sms.single_sender(phone_number, template_code, params)
...
```    

## Development 开发

按照腾讯云官方提供的 SMS 签名样例做了简单的 spect 测试，可以 clone 项目后，在根目录下用命令行运行以下命令测试：

    $ bundle exec rspec spec


## License 许可

MIT 协议下的开源项目。 [MIT License](http://opensource.org/licenses/MIT).