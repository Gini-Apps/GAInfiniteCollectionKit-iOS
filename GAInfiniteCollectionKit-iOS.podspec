#
# Be sure to run `pod lib lint GAInfiniteCollectionKit-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GAInfiniteCollectionKit-iOS'
  s.version          = '3.0.4'
  s.summary          = 'Add infinite scrolling to UICollectionView'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

 s.description      = <<-DESC
 Add infinite scrolling to UICollectionView.
DESC

  s.homepage         = 'https://github.com/Gini-Apps/GAInfiniteCollectionKit-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'idoMeirov' => 'idom@gini-apps.com' }
  s.source           = { :git => 'https://github.com/Gini-Apps/GAInfiniteCollectionKit-iOS.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

 s.frameworks  = 'UIKit'
 s.ios.deployment_target = '9.0'

  s.source_files = 'GAInfiniteCollectionKit-iOS/Classes/**/*'
  
end
