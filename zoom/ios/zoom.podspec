#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint zoom.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'zoom'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://vurilo.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'vurilo' => 'developer@vurilo.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-framework MobileRTC', 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0' 
  
  s.preserve_paths = 'MobileRTC.xcframework', 'MobileRTCResources.bundle'
  s.vendored_frameworks = 'MobileRTC.xcframework'
  s.resource = 'MobileRTCResources.bundle'
end
