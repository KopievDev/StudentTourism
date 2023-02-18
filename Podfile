# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'StudentTourism' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'lottie-ios', '= 3.4.1'
  pod 'SDWebImage', '= 5.13.4'
  pod 'SwiftGen'
  # Pods for StudentTourism

end
post_install do |installer|
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
#      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
#      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
