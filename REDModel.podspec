#
# Be sure to run `pod lib lint REDModel.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "REDModel"
  s.version          = "0.2.0"
  s.summary          = "NSUserDefaults wrapper"
  s.description      = <<-DESC
                       NSUserDefaults wrapper - http://blog.red.to/posts/redmodel.html
                       DESC
  s.homepage         = "https://github.com/reddavis/REDModel"
  s.license          = 'MIT'
  s.author           = { "Red Davis" => "me@red.to" }
  s.source           = { :git => "https://github.com/reddavis/REDModel.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/reddavis'

  s.platform = :ios, '7.0'
  s.platform = :osx
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
