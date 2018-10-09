#
# Be sure to run `pod lib lint ZQSearch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZQSearch'
  s.version          = '0.1.0'
  s.summary          = 'Search，SearchBar,  仿《饿了么》搜索栏。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Search，SearchBar,  仿《饿了么》搜索栏。自定义搜索结果界面。搜索主页、模糊匹配、结果界面之间的状态切换。支持搜索历史和热门设置'

  s.homepage         = 'https://github.com/rabbitmouse/ZQSearchController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = "MIT"
  s.author           = { '578259544@qq.com' => '578259544@qq.com' }
  s.source           = { :git => 'https://github.com/rabbitmouse/ZQSearchController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZQSearchController/Classes/**/*'
  
  s.resources     = 'ZQSearchController/Images/*.{png,jpg}'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SDWebImage', '~> 4.0'
end
