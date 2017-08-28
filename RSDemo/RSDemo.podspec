#
# Be sure to run `pod lib lint RSDemo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'RSDemo'
    s.version          = '0.1.0'
    s.summary          = 'A short description of RSDemo.'
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'http://www.ddtkj.com'
    
    s.license           = {
        :type => 'Copyright',
        :text => <<-LINCENSE
        山西大德通科技有限公司版权所有.
        LINCENSE
    }
    s.author           = { 'yaoqi' => 'yaoqi@ddtkj.com' }
    s.source           = { :svn => 'https://192.168.251.64:8443/svn/DDTKJ-SRC-APP/ios/components/<PATH>/RSDemo' }
    
    s.ios.deployment_target = '7.0'
    
    s.source_files = 'RSDemo/Classes/**/*'
    
    # s.resources = 'RSDemo/Xibs/*.xib'
    # s.resource_bundles = {
    #   'RSDemo' => ['RSDemo/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'

    # s.prefix_header_contents = '#import "YGCommon.h"'
    # s.prefix_header_contents = '#import "CWCommon.h"'
end

