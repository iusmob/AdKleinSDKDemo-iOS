platform :ios, '10.0'

workspace 'AdKleinSDKDemo'

target 'Demo' do
  project 'Demo/Demo.xcodeproj'
  pod 'Bugly'

  #至少接入一个平台，但不推荐全部接入。如果不清楚需要哪些平台可以咨询媒介。
  #没有接入广告的平台建议注释掉，以减小不必要的体积。
  pod 'AdKleinSDK/AdKleinSDKPlatforms/GDT'     # 优量汇(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/CSJ'     # 穿山甲(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Mobius'  # 莫比乌斯(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/BaiDu'   # 百青藤(可选)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Google'  # Admob(可选)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Smaato'  # Smaato(可选)
  #注意，接入快手时，需要关闭bitcode，且不支持M1芯片下的模拟器
  pod 'AdKleinSDK/AdKleinSDKPlatforms/KS',     # 快手(可选)
end
target 'SwiftDemo' do
  project 'SwiftDemo/SwiftDemo.xcodeproj'
  pod 'Bugly'

  #至少接入一个平台，但不推荐全部接入。如果不清楚需要哪些平台可以咨询媒介。
  #没有接入广告的平台建议注释掉，以减小不必要的体积。
  pod 'AdKleinSDK/AdKleinSDKPlatforms/GDT'     # 优量汇(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/CSJ'     # 穿山甲(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Mobius'  # 莫比乌斯(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/BaiDu'   # 百青藤(可选)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Google'  # Admob(可选)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Smaato'  # Smaato(可选)
  #注意，接入快手时，需要关闭bitcode，且不支持M1芯片下的模拟器
  pod 'AdKleinSDK/AdKleinSDKPlatforms/KS',     # 快手(可选)
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
