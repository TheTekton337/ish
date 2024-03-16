Pod::Spec.new do |spec|
  spec.name         = 'iSHKit'
  spec.version      = '0.1.0'
  spec.summary      = 'A toolkit for integrating iSH shell functionality into iOS apps and React Native modules.'
  spec.description  = <<-DESC
                       iSHKit is a toolkit designed to extend the iSH app's Linux shell capabilities to iOS apps and React Native modules, providing developers with a powerful tool for integrating shell-based tasks directly into their applications.
                       DESC
  spec.homepage     = 'https://github.com/yourgithubusername/iSHKit'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { 'Your Name' => 'youremail@example.com' }
  spec.platform     = :ios, '11.0'
  spec.source       = { :git => 'https://github.com/yourgithubusername/iSHKit.git', :tag => spec.version.to_s }
  spec.source_files  = 'iSHKit/**/*.{h,m,swift}'
  spec.exclude_files = 'iSHKit/**/*.plist'
  spec.ios.frameworks = ['UIKit', 'Foundation']
  
  # If iSHKit depends on other pods, specify them here
  # spec.dependency 'SomeOtherPod'
  
  # Include resources if there are any
  # spec.resources = 'path/to/resources/*.png'
  
  # Specify public_header_files if needed
  # spec.public_header_files = 'iSHKit/**/*.h'
  
  # If iSHKit includes Swift code, specify the Swift version
  # spec.swift_version = '5.0'
end

