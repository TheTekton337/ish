Pod::Spec.new do |spec|
  spec.name         = 'iSHKit'
  spec.version      = '0.1.0'
  spec.summary      = 'A toolkit for integrating iSH shell functionality into iOS apps and React Native modules.'
  spec.description  = <<-DESC
                       iSHKit is a toolkit designed to extend the iSH app's Linux shell capabilities to iOS apps and React Native modules, providing developers with a powerful tool for integrating shell-based tasks directly into their applications.
                       DESC
  spec.homepage     = 'https://github.com/TheTekton337/ish'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { 'Terrance Wood' => 'pntkl@ixqus.com' }
  spec.platform     = :ios, '11.0'
  spec.source       = { :git => 'https://github.com/TheTekton337/ish.git', :tag => spec.version.to_s }
  spec.ios.frameworks = ['UIKit', 'Foundation', 'CoreLocation', 'SystemConfiguration']
  spec.libraries    = 'bz2', 'iconv', 'resolv'

  # Global build settings and definitions
  spec.pod_target_xcconfig = {
    'USE_HEADERMAP' => 'YES',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'ENABLE_BITCODE' => 'NO',
    'HEADER_SEARCH_PATHS' => '"$(PODS_TARGET_SRCROOT)/iSHKit" $(inherited)',
    'LIBRARY_SEARCH_PATHS' => '"$(PODS_TARGET_SRCROOT)/iSHKit/lib" $(inherited)',
  }

  # Use prepare_command to build static libraries with xcodebuild
  spec.prepare_command = <<-CMD
    #!/bin/sh
    # set -e
    # Assuming the iSHKit target is part of the iSH.xcodeproj
    PODS_TARGET_SRCROOT=$PWD
    #echo "SRCY: ${HOME}"
    #echo "SRCY2: ${PWD}"
    export PATH="$HOME/homebrew/bin:$PATH"
    cd $PODS_TARGET_SRCROOT/../deps/libapps
    ./hterm/bin/mkdist
    cp -r "hterm/dist/." $PODS_TARGET_SRCROOT/../Frameworks
    cd ../..
    # Create a unique build directory for iSHKit within the pod's directory structure
    ISHKIT_BUILD_DIR="${PODS_TARGET_SRCROOT}/build"
    mkdir -p "${ISHKIT_BUILD_DIR}"
    xcodebuild -project "${PODS_TARGET_SRCROOT}/../iSH.xcodeproj" \
             -target "iSHKit" \
             -configuration Release \
             -sdk iphoneos \
             IPHONEOS_DEPLOYMENT_TARGET=12.0 \
             BUILD_DIR="${ISHKIT_BUILD_DIR}" \
             clean build
    # Copy the built static library into the pod directory for vendoring
    mkdir -p "${PODS_TARGET_SRCROOT}/iSHKit/lib/"
    cp "${PODS_TARGET_SRCROOT}/build/Release-iphoneos/*.a" "${PODS_TARGET_SRCROOT}/iSHKit/lib/"
    
    # FileProvider note: Since prepare_command can't be used in subspecs, ensure any necessary setup for all components is covered here.
  CMD
  
  # Vendored libraries
  spec.vendored_libraries = 'iSHKit/lib/libiSHKit.a', 'iSHKit/lib/libfakefs.a', 'iSHKit/lib/libish.a', 'iSHKit/lib/libish_emu.a', 'iSHKit/lib/libarchive.a'

  # Resource bundles configuration
  spec.resource_bundles = {
    'iSHKit' => [
      'app/{localization}/*.storyboard',
      'app/terminal/*.{html,js,css}',
      'deps/libapps/hterm/dist/js/hterm_all.js',
      'app/icons/*.png',
      'app/icons/Icons.plist'
    ]
  }

  spec.public_header_files = [
    'app/Terminal.h',
    'iSHKit/iSHKit.h',
    'iSHKit/Includes/**/*.h',
    'iSHKit/Sources/**/*.h'
  ]

  # Subspec for iSHShared
  # spec.subspec 'iSHShared' do |ss|
  #   ss.vendored_libraries = 'iSHKit/lib/libiSHShared.a'
  #   # You might specify additional settings specific to this library here.
  # end

  # # Subspec for ish
  # spec.subspec 'ish' do |ss|
  #   ss.vendored_libraries = 'iSHKit/lib/libish.a'
  #   # Additional settings for ish
  # end

  # # Subspec for fakefs
  # spec.subspec 'fakefs' do |ss|
  #   ss.vendored_libraries = 'iSHKit/lib/libfakefs.a'
  #   # Additional settings for fakefs
  # end

  # # Subspec for ish_emu
  # spec.subspec 'ish_emu' do |ss|
  #   ss.vendored_libraries = 'iSHKit/lib/libish_emu.a'
  #   # Additional settings for ish_emu
  # end

  # # Subspec for Archive
  # spec.subspec 'Archive' do |ss|
  #   ss.vendored_libraries = 'iSHKit/lib/libarchive.a'
  #   # Additional settings for Archive
  # end

  # spec.subspec 'FileProvider' do |ss|
  #   # As prepare_command cannot be used here, ensure to detail manual steps in your documentation.
  #   ss.preserve_paths = 'app/FileProvider/Info.plist', 'app/FileProvider/FileProvider.entitlements'
  #   ss.frameworks = 'UIKit', 'Foundation', 'CoreData'
  #   ss.source_files = 'app/FileProvider/**/*.{h,m,swift}'
  #   ss.resources = 'app/FileProvider/*.xcassets'
  #   ss.vendored_libraries = 'iSHKit/lib/libish_emu.a', 'iSHKit/lib/libfakefs.a'
  # end
  
  # If iSHKit depends on other pods, specify them here
  # spec.dependency 'SomeOtherPod'
  
  # Include resources if there are any
  # spec.resources = 'path/to/resources/*.png'
  
  # Specify public_header_files if needed
  # spec.public_header_files = 'iSHKit/**/*.h'
  
  # If iSHKit includes Swift code, specify the Swift version
  # spec.swift_version = '5.0'
end
