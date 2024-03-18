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
  spec.source_files = 'iSHKit/**/*.{h,m}', 'iSHKit/Libraries/**/*.a'
  spec.ios.frameworks = ['UIKit', 'Foundation', 'CoreLocation', 'SystemConfiguration']
  spec.libraries    = 'bz2', 'iconv', 'resolv'
  spec.vendored_libraries = 'iSHKit/Libraries/*.a'
  spec.vendored_frameworks = 'iSHKit/Frameworks/iSHKit.framework'

  # Global build settings and definitions
  spec.pod_target_xcconfig = {
    'USE_HEADERMAP' => 'YES',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'ENABLE_BITCODE' => 'NO',
    'DISABLE_MANUAL_TARGET_ORDER_BUILD_WARNING' => 'YES',
    'HEADER_SEARCH_PATHS' => '$(inherited) "$(PODS_TARGET_SRCROOT)/iSHKit"',
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PODS_TARGET_SRCROOT)/iSHKit/Frameworks"',
    'LIBRARY_SEARCH_PATHS' => '$(inherited) "$(PODS_TARGET_SRCROOT)/iSHKit/Libraries"',
    'OTHER_LDFLAGS' => '$(inherited)',
  }

  # Use prepare_command to build static libraries and framework with xcodebuild
  spec.prepare_command = <<-CMD
    #!/bin/sh
    set -e
    export PATH=$PATH:/usr/local/bin
    export PATH=$HOME/homebrew/bin:$PATH

    SDKS=("iphoneos" "iphonesimulator")
    #LIBS=("libiSHShared.a" "libfakefs.a" "libish.a" "libish_emu.a" "libarchive.a")
    LIBS=("libiSHShared.a" "libish.a" "libarchive.a")
    FRAMEWORKS=("iSHKit.framework")
    PODS_TARGET_SRCROOT=$PWD
    ISHKIT_BUILD_DIR="${PODS_TARGET_SRCROOT}/build"
    LIBRARIES_PATH="${PODS_TARGET_SRCROOT}/Libraries"
    FRAMEWORKS_PATH="${PODS_TARGET_SRCROOT}/Frameworks"

    cd $PODS_TARGET_SRCROOT/../deps/libapps
    ./hterm/bin/mkdist
    cp -r "hterm/dist/." "${FRAMEWORKS_PATH}"
    cd ../..

    rm -rf "${ISHKIT_BUILD_DIR}" "${LIBRARIES_PATH}" "${FRAMEWORKS_PATH}"
    # mkdir -p "${ISHKIT_BUILD_DIR}"
    mkdir -p "${LIBRARIES_PATH}"
    mkdir -p "${FRAMEWORKS_PATH}"

    for SDK in "${SDKS[@]}"; do
      xcodebuild -project "${PODS_TARGET_SRCROOT}/../iSH.xcodeproj" \
                -target "iSHKit" \
                -configuration Release \
                -sdk $SDK \
                IPHONEOS_DEPLOYMENT_TARGET=12.0 \
                BUILD_DIR="${ISHKIT_BUILD_DIR}/${SDK}" \
                BUILD_LIBRARY_FOR_DISTRIBUTION=YES
                #clean build
    done

    # Create universal binaries
    for LIB in "${LIBS[@]}"; do
      lipo -create -output "${LIBRARIES_PATH}/${LIB}" \
      "${ISHKIT_BUILD_DIR}/iphoneos/Release-iphoneos/${LIB}" \
      "${ISHKIT_BUILD_DIR}/iphonesimulator/Release-iphonesimulator/${LIB}"
    done

    # Copy the framework from the device build (assuming it's the same for both architectures)
    for FRAMEWORK in "${FRAMEWORKS[@]}"; do
      cp -pR "${ISHKIT_BUILD_DIR}/iphoneos/Release-iphoneos/${FRAMEWORK}" "${FRAMEWORKS_PATH}/"
    done
  CMD

  spec.resource_bundles = {
    'iSHKit' => [
      'app/{localization}/*.storyboard',
      'app/terminal/*.{html,js,css}',
      'deps/libapps/hterm/dist/js/hterm_all.js',
      'app/icons/*.png',
      'app/icons/Icons.plist'
    ]
  }

  spec.public_header_files = 'iSHKit/**/*.h'
end
