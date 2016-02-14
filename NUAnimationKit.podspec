#
# Be sure to run `pod lib lint NUAnimationKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NUAnimationKit"
  s.version          = "0.2.2"
  s.summary          = "DSL to wrap UIView animation chaining into a cleaner structure"

  s.description      = <<-DESC
UIView animation wrapper that simplifies chaining of multiple animation steps, each with their own completion blocks. Also supports progress-based animations using CADisplayKit synchronization
                       DESC

  s.homepage         = "git@github.com:nubank/NUAnimationKit.git"
  s.license          = 'MIT'
  s.author           = { "Victor Maraccini" => "vgm.maraccini@gmail.com" }
  s.source           = { :git => "git@github.com:nubank/NUAnimationKit.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
