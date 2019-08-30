#
# Be sure to run `pod lib lint PoporWKWebVC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PoporWKWebVC'
  s.version          = '1.01'
  s.summary          = '使用UIWKWebView,支持左右边缘侧滑实现网页的前进后退;点击导航栏返回按钮实现网页内部返回,增加了关闭按钮,类似微信查看网页方式.'

  s.homepage         = 'https://github.com/popor/PoporWKWebVC'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangkq' => '908891024@qq.com' }
  s.source           = { :git => 'https://github.com/popor/PoporWKWebVC.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'PoporWKWebVC/Classes/**/*'
  
  s.dependency 'PoporUI/IToast'
  s.dependency 'Masonry'
  
end
