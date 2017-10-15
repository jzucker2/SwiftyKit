project 'Example/SwiftyKit'
workspace 'SwiftyKit'
use_frameworks!

platform :ios, '10.0'

target 'SwiftyKit_Example' do
  pod 'SwiftyKit', :path => '.'

  target 'SwiftyKit_Tests' do
    inherit! :search_paths
    pod 'SwiftyKit', :path => '.'
  end
  target 'SwiftyKit_Networking_Tests' do
      inherit! :search_paths
      pod 'DVR'
      pod 'SwiftyKit', :path => '.'      
  end
end
