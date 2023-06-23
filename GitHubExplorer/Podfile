
platform :ios, '11.0'
install! 'cocoapods', :disable_input_output_paths => true
inhibit_all_warnings!
load 'PodfileSupport.rb'

# Pods
def external_libs
  pod 'SwiftLint'
  pod 'IQKeyboardManagerSwift'
end

target 'GitHubExplorer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  external_libs
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
