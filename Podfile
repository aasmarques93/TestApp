# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TestApp' do
  use_frameworks!

  pod 'Moya'
  pod 'Alamofire'
  pod 'Cache'
  pod 'Bond', '~> 6.0-beta'
  pod 'RAMAnimatedTabBarController'
  pod 'SDWebImage'
  pod 'FCAlertView'
  pod 'NVActivityIndicatorView'
  pod 'SwiftyJSON'
  pod 'lottie-ios'
  pod 'GhostTypewriter'
  pod 'CollectionViewSlantedLayout'
  pod 'NVActivityIndicatorView'
  pod 'ViewAnimator'
  pod 'Hero'

  # Pods for TestApp

  target 'TestAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TestAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

require 'FileUtils'

post_install do |installer|
    FileUtils.rm("Pods/Moya/Sources/Moya/MoyaProvider+Defaults.swift")
    FileUtils.cp("TestApp/Third\ Party/Moya/MoyaProvider+Defaults.swift", "Pods/Moya/Sources/Moya/MoyaProvider+Defaults.swift")
end
