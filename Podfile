source 'https://github.com/CocoaPods/Specs.git'
# Uncomment this line to define a global platform for your project
platform :ios, '8.0'

# ignore all warnings from all pods
inhibit_all_warnings!

# Uncomment this line if you're using Swift
use_frameworks!

# Test Libraries
def test_pods
  pod 'Quick'
  pod 'Nimble'
end

# Our Libraries
def libraries
  pod 'SVProgressHUD'
	pod 'INTULocationManager' # for user location
  pod 'SwiftEventBus', :git => 'https://github.com/cesarferreira/SwiftEventBus.git' # for publish-subscribe-style communication
  pod 'RealmSwift' # database
end

target 'LocationManager' do
  platform :ios, '8.0'
  libraries
end

target 'LocationManagerTests' do
  platform :ios, '8.0'
  libraries
  test_pods
end
