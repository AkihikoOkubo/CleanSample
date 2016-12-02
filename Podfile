# Uncomment the next line to define a global platform for your project
platform :ios, '10.1'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'CleanSample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for CleanSample
  pod 'SwiftyJSON' , '3.1.3'
  pod 'Alamofire' , '4.2.0'
  pod 'Bolts-Swift' , '1.3.0'
  pod 'Bond' , '5.1'
  pod 'Validator' , '2.1.1'
  pod 'RealmSwift' , '2.1.0'
  pod 'NVActivityIndicatorView' , '3.0'
  pod 'Swinject', '2.0.0-beta.2'
  pod 'Kingfisher'
  pod 'Swinject', '2.0.0-beta.2'
  
  target 'CleanSampleTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'CleanSampleUITests' do
    inherit! :search_paths
    testing_pods
  end

end
