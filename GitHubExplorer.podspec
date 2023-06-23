$specVersion = "1.0.0"
$specSource = { :git => "https://github.com/Danilo13surf/GitHubExplorer", :branch => "main" }

Pod::Spec.new do |s|
  s.name             = 'GitHubExplorer'
  s.version          = $specVersion
  s.summary          = 'A short description of GitHubExplorer.'

  s.homepage         = 'https://github.com/Danilo13surf/GitHubExplorer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Danilo Carlos Ribeiro' => 'd.c.ribeiroo@gmail.com' }
  s.source           = $specSource

  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.source_files = ['GitHubExplorer/Sources/**/*.{h,m,swift}']
  s.static_framework = true
  s.swift_version = '5'
  s.resources = ['GitHubExplorer/Resources/**/*.{png,jpeg,jpg,storyboard,xib,lproj,ttf,xcassets,strings,json}']
  s.dependency 'IQKeyboardManagerSwift'
end
