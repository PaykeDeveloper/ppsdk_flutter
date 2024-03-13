#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ppsdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ppsdk_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Profile Passportのプラグイン。'
  s.description      = <<-DESC
Profile Passportのプラグイン。
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.preserve_paths = 'PPSDKFrameworks/ProfilePassportAdid.xcframework', 'PPSDKFrameworks/ProfilePassportBeacon.xcframework', 'PPSDKFrameworks/ProfilePassportCore.xcframework', 'PPSDKFrameworks/ProfilePassportGeofence.xcframework', 'PPSDKFrameworks/ProfilePassportNotice.xcframework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework ProfilePassportAdid -framework ProfilePassportBeacon -framework ProfilePassportCore -framework ProfilePassportGeofence -framework ProfilePassportNotice' }
  s.vendored_frameworks = 'ProfilePassportAdid.xcframework', 'ProfilePassportBeacon.xcframework', 'ProfilePassportCore.xcframework', 'ProfilePassportGeofence.xcframework', 'ProfilePassportNotice.xcframework'
end
