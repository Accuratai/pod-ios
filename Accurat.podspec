#
#  Be sure to run `pod spec lint Accurat.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Accurat"
  s.version      = "1.0.5"
  s.summary      = "Accurat SDK."
  s.description  = <<-DESC
  Accurat SDK description
                   DESC

  s.homepage     = "https://accurat.ai/"

  s.license      = { :type => 'TBD', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE

  }

  s.author       = { "Mathias Van Houtte" => "mathias.van.houtte@endare.com" }

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://gitlab.com/accuratai/pod-ios", :tag => s.version }
  s.ios.vendored_frameworks = 'Accurat.framework'

end
