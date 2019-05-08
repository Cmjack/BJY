Pod::Spec.new do |s|

    s.name          = 'BJLiveUI'
    s.version       = '1.3.9'
    s.summary       = 'BJLiveUI SDK.'
    s.description   = 'BJLiveUI SDK for iOS.'

    s.homepage      = 'http://www.baijiayun.com/'
    s.license       = 'MIT'
    s.author        = { 'MingLQ' => 'minglq.9@gmail.com' }

    s.platform      = :ios
    s.ios.deployment_target = '8.0'

    s.source        = {
        :git => 'http://git.baijiashilian.com/open-ios/BJLiveUI.git',
        :tag => s.version.to_s
    }
    s.pod_target_xcconfig = {
        "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES",
        "ENABLE_BITCODE" => "NO", # TODO: BJHLMediaPlayer 支持 bitcode
        # use <"> but not <'> for #{s.name} and #{s.version}
        "GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) BJLIVEUI_NAME=#{s.name} BJLIVEUI_VERSION=#{s.version}"
    }

    s.default_subspecs = ['static']

    s.subspec 'static' do |ss|
        ss.ios.preserve_paths       = 'frameworks/BJLiveUI.framework'
        ss.ios.source_files         = 'frameworks/BJLiveUI.framework/Versions/A/Headers/**/*.h'
        ss.ios.public_header_files  = 'frameworks/BJLiveUI.framework/Versions/A/Headers/**/*.h'
        ss.ios.resource             = 'frameworks/BJLiveUI.framework/Versions/A/Resources/BJLiveUI.bundle'
        ss.ios.vendored_frameworks  = 'frameworks/BJLiveUI.framework'
        ss.dependency 'BJLiveUI/static.dependencies'
    end
    s.subspec 'static.source' do |ss|
        ss.public_header_files = [
            'classes/**/BJLiveUI.h',
            'classes/**/BJLRoomViewController.h',
            'classes/**/BJLOverlayViewController.h',
            'classes/**/BJLOverlayContainerController.h'
        ]
        ss.source_files  = ["classes", "classes/**/*.{h,m}"]
        ss.resource_bundles = {
            "BJLiveUI" => ["bundles/**/*.xcassets"]
        }
        ss.dependency 'BJLiveUI/static.dependencies'
    end
    s.subspec 'static.dependencies' do |ss|
        ss.frameworks = ['CoreGraphics', 'Foundation', 'MobileCoreServices', 'Photos', 'SafariServices', 'UIKit', 'WebKit']
        ss.dependency 'BJLiveBase'
        ss.dependency 'BJLiveBase/Base'
        ss.dependency 'BJLiveBase/Auth'
        ss.dependency 'BJLiveBase/Ext'
        ss.dependency 'BJLiveBase/HUD'
        ss.dependency 'BJLiveBase/Masonry'
        ss.dependency 'BJLiveBase/Networking'
        ss.dependency 'BJLiveBase/WebImage/AFNetworking'
        ss.dependency 'BJLiveCore', '~> 1.3.9'
        ss.dependency 'Masonry'
        ss.dependency 'QBImagePickerController', '~> 3.0'
    end

    # weak
    s.subspec 'weak' do |ss|
        ss.ios.preserve_paths       = 'frameworks/BJLiveUI.framework'
        ss.ios.source_files         = 'frameworks/BJLiveUI.framework/Versions/A/Headers/**/*.h'
        ss.ios.public_header_files  = 'frameworks/BJLiveUI.framework/Versions/A/Headers/**/*.h'
        ss.ios.resource             = 'frameworks/BJLiveUI.framework/Versions/A/Resources/BJLiveUI.bundle'
        ss.ios.vendored_frameworks  = 'frameworks/BJLiveUI.framework'
        ss.dependency 'BJLiveUI/weak.dependencies'
    end
    s.subspec 'weak.source' do |ss|
        ss.public_header_files = [
            'classes/**/BJLiveUI.h',
            'classes/**/BJLRoomViewController.h',
            'classes/**/BJLOverlayViewController.h',
            'classes/**/BJLOverlayContainerController.h'
        ]
        ss.source_files  = ["classes", "classes/**/*.{h,m}"]
        ss.resource_bundles = {
            "BJLiveUI" => ["bundles/**/*.xcassets"]
        }
        ss.dependency 'BJLiveUI/static.dependencies'
    end
    s.subspec 'weak.dependencies' do |ss|
        ss.frameworks = ['CoreGraphics', 'Foundation', 'MobileCoreServices', 'Photos', 'SafariServices', 'UIKit', 'WebKit']
        ss.dependency 'BJLiveBase'
        ss.dependency 'BJLiveBase/Base'
        ss.dependency 'BJLiveBase/Auth'
        ss.dependency 'BJLiveBase/Ext'
        ss.dependency 'BJLiveBase/HUD'
        ss.dependency 'BJLiveBase/Masonry'
        ss.dependency 'BJLiveBase/Networking'
        ss.dependency 'BJLiveBase/WebImage/AFNetworking'
        ss.dependency 'BJLiveCore', '1.3.9-weak'
        ss.dependency 'Masonry'
        ss.dependency 'QBImagePickerController', '~> 3.0'
    end

end
