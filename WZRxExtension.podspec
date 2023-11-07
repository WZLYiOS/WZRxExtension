#
# Be sure to run `pod lib lint WZRxExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WZRxExtension'
  s.version          = '0.2.0'
  s.summary          = 'A short description of WZRxExtension.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/WZLYiOS/WZRxExtension'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LiuSky' => '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/WZLYiOS/WZRxExtension.git', :tag => s.version.to_s }

  s.static_framework = true
  s.swift_version         = '5.0'
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "WZRxExtension/Classes/DisposeBag/*", "WZRxExtension/Classes/UI/*", "WZRxExtension/Classes/Tool/*"
  end

  s.subspec "DisposeBag" do |ss|
    ss.source_files = "WZRxExtension/Classes/DisposeBag/*"
  end
  
  
  s.subspec "UI" do |ss|
    ss.source_files = "WZRxExtension/Classes/UI/*"
  end
  
  
  s.subspec "Tool" do |ss|
    ss.source_files = "WZRxExtension/Classes/Tool/*"
  end
  
  s.dependency "RxSwift", ">= 5.1.0"
  s.dependency "RxCocoa", ">= 5.1.0"
end
