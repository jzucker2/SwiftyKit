#
# Be sure to run `pod lib lint SwiftyKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyKit'
  s.version          = '0.4.0'
  s.summary          = 'A collection of best practices and quick tricks.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A collection of useful programming paradigms and shared code between Swift projects.
                       DESC

  s.homepage         = 'https://github.com/jzucker2/SwiftyKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jzucker2' => 'jordan.zucker@gmail.com' }
  s.source           = { :git => 'https://github.com/jzucker2/SwiftyKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jzucker'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SwiftyKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftyKit' => ['SwiftyKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
