#
#  Be sure to run `pod spec lint Accurat.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Accurat"
  s.version      = "2.1.10"
  s.homepage     = "https://gitlab.com/accuratai/pod-ios/"
  s.summary      = "The Accurat iOS SDK puts location intelligence at your fingertips."
  s.author                = { 'Accurat' => 'sdk@accurat.ai' }
  s.license               = { :type => 'Copyright',
                                :text => 'Copyright (c) 2024 Accurat BV. All rights reserved.'}
  s.ios.deployment_target = "10.0"

  s.source       = { :git => "https://gitlab.com/accuratai/pod-ios", :tag => s.version }
  s.ios.vendored_frameworks = 'AccuratSDK.xcframework'

end


