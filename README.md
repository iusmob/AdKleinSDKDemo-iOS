# 接入文档

[https://doc.iusmob.com/iOS.html](https://doc.iusmob.com/iOS.html)

# 初始化

在项目根目录下(不是project文件所在目录)执行`pod install`即可。

版本有更新时，请运行`pod update AdKleinSDK`。

# 注意事项

M1芯片的模拟器下运行前，需要在podfile中添加如下配置，并重新安装pod依赖。

```
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
```
