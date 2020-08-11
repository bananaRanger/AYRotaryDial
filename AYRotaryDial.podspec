#
# Be sure to run `pod lib lint AYRotaryDial.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AYRotaryDial'
  s.version          = '1.0.1'
  s.summary          = 'AYRotaryDial is the UI control gives you the possibility for input phone number like with cool old rotary dial phone.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Customizable control that gives the user the possibility for input phone number like with cool old rotary dial phone..
                       DESC

  s.homepage         = 'https://github.com/bananaRanger/AYRotaryDial'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anton Yereshchenko' => 'antonyereshchenko@gmail.com' }
  s.source           = { :git => 'https://github.com/bananaRanger/AYRotaryDial.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version  = '5.0'
  
  s.source_files = 'AYRotaryDial/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AYRotaryDial' => ['AYRotaryDial/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
