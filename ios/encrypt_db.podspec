#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint encrypt_db.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'encrypt_db'
  s.version          = '0.0.1'
  s.summary          = 'A Swing Technologies Product.'
  s.description      = <<-DESC
A Swing Technologies Product.
                       DESC
  s.homepage         = 'https://opensource.appworld.in'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'support@swingtechnologies.in' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
