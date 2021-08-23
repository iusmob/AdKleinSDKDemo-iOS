platform :ios, '10.0'

target 'Demo' do

  #至少接入一个平台，但不推荐全部接入。如果不清楚需要哪些平台可以咨询媒介。
  #没有接入广告的平台建议注释掉，以减小不必要的体积。
  pod 'AdKleinSDK/AdKleinSDKPlatforms/GDT'     # 优量汇(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/CSJ'     # 穿山甲(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Mobius'  # 莫比乌斯(推荐)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/BaiDu'   # 百青藤(可选)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Google'  # Admob(可选)
  pod 'AdKleinSDK/AdKleinSDKPlatforms/Smaato'  # Smaato(可选)

  #以下为调试工具
  pod 'HDWindowLogger'
  pod 'Bugly'

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
