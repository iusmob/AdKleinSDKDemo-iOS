# 莫比乌斯SDK iOS SDK——接入文档

## 1. 概述

### 1.1 概述

尊敬的开发者朋友，欢迎您使用莫比乌斯SDK。通过本文档，您可以快速完成多平台广告SDK的集成。

### 1.2 莫比乌斯SDK组成结构

聚合SDK主要由**莫比乌斯核心SDK**（简称莫比乌斯SDK）和**一个或多个**三方广告平台SDK构成。

### 1.3 三方广告平台名称概述

| Name      | 平台名称   | 平台别称 |
| --------- | -------- | -------- |
| mobius    | 莫比乌斯   | 莫比乌斯 |
| gdt       | 广点通   | 优量汇   |
| toutiao   | 头条     | 穿山甲   |
| baidu     | 百度     | 百青藤   |
| admob   | AdMob    | 谷歌     |
| smaato | Smaato | 誉广 |


## 2. 支持的广告类型

<table>
  <tr>
    <th style="width:150px">类型</th>
    <th>简介</th>
    <th>适用场景</th>
  </tr>
  <tr>
    <td><a href="#ad_splash">开屏广告</a></td>
    <td>开屏广告以APP启动作为曝光时机的模板广告，需要将开屏广告视图添加到承载的广告容器中，提供5s可感知广告展示</td>
    <td>APP启动界面常会使用开屏广告</td>
  </tr>
  <tr>
      <td><a href="#ad_native">信息流广告</a></td>
      <td>信息流广告集合原生自渲染广告和模板广告两种，可以通过后台配置和SDK相关方法判断进行不同的渲染，以满足不同的样式需求</td>
      <td>信息流列表，轮播控件，固定位置都是较为适合</td>
    </tr>
  <tr>
    <td><a href="#ad_banner">Banner广告</a></td>
    <td>Banner广告是横向贯穿整个可视页面的模板广告，需要将Banner广告视图添加到承载的广告容器中</td>
    <td>任意界面的固定位置，不建议放在TableView这种滚动布局中当item   </td>
  </tr>
   <tr>
    <td><a href="#ad_reward_video">激励视频广告</a></td>
    <td>将短视频融入到APP场景当中，用户观看短视频广告后可以给予一些应用内奖励</td>
    <td>常出现在游戏的复活、任务等位置，或者网服类APP的一些增值服务场景</td>
  </tr>
   <tr>
    <td><a href="#ad_fullscreen_video">全屏视频广告</a></td>
    <td>类似激励视频，与激励视频不同的是，全屏视频广告在观看一定时长后即可跳过广告，无需全部观看完成，有视频跳过回调，但是没有激励回调</td>
    <td>常出现在游戏的复活、任务等位置，或者网服类APP的一些增值服务场景</td>
  </tr>
   <tr>
    <td><a href="#ad_interstitial">插屏广告</a></td>
    <td>插屏广告是移动广告的一种常见形式，在应用流程中弹出，当应用展示插屏广告时，用户可以选择点击广告，访问其目标网址，也可以将其关闭并返回应用</td>
    <td>在应用执行流程的自然停顿点，适合投放这类广告</td>
  </tr>
</table>

## 3. Demo下载链接

在管理后台的接入中心下载。

## 4. SDK接入流程

### 4.1 pod 接入 [强烈推荐]

推荐使用pod命令：

```objectivec
#至少接入一个平台，但不推荐全部接入。如果不清楚需要哪些平台可以咨询媒介。
#没有接入广告的平台建议注释掉，以减小不必要的体积。
pod 'AdKleinSDK/AdKleinSDKPlatforms/GDT'        # 优量汇(推荐)
pod 'AdKleinSDK/AdKleinSDKPlatforms/CSJ'        # 穿山甲(推荐)
pod 'AdKleinSDK/AdKleinSDKPlatforms/Mobius'     # 莫比乌斯(推荐)
#pod 'AdKleinSDK/AdKleinSDKPlatforms/BaiDu'      # 百青藤(可选)
#pod 'AdKleinSDK/AdKleinSDKPlatforms/Google'    # Admob(可选)
#pod 'AdKleinSDK/AdKleinSDKPlatforms/Smaato'    # Smaato(可选)
```

**注意：** 接入Google的Admob广告请务必参考5.1.1在Info.plist中添加`GADApplicationIdentifier`信息。

### 4.2 手动导入

从接入中心下载 SDK，并将各SDK拖入工程 。

在TARGETS -> Build Phases中找到Link Binary With Libraries，点击“+”，依次添加下列依赖库：

```objectivec
AdSupport.framework
CoreLocation.framework
QuartzCore.framework
SystemConfiguration.framework
CoreTelephony.framework
libz.tbd
WebKit.framework (Optional)
libxml2.tbd
Security.framework
StoreKit.framework
AVFoundation.framework
CoreMedia.framework
libresolv.9.tbd
MobileCoreServices.framework
MediaPlayer.framework
CoreMotion.framework
Accelerate.framework
libc++.tbd
libsqlite3.tbd
ImageIO.framework
libbz2.tbd
```

### 4.3 工程环境配置

1. 在Info.plist 添加支持 Http 访问字段

```objectivec
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

2. 确保`Build Settings`中`Other Linker Flags `存在`-ObjC`

3. 在Info.plist中添加应用访问白名单(`LSApplicationQueriesSchemes`)，有助于提升广告收益

推荐设置如下：

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <!-- 电商 -->
  <string>taobao</string><!-- 淘宝  -->
  <string>tmall</string><!-- 天猫  -->
  <string>jdlogin</string><!-- 京东  -->
  <string>pinduoduo</string> <!-- 拼多多  -->
  <string>kaola</string> <!-- 网易考拉  -->
  <string>yanxuan</string> <!-- 网易严选  -->
  <string>vipshop</string> <!-- 唯品会  -->
  <string>suning</string> <!-- 苏宁  -->
  <string>mishopv1</string> <!-- 小米商城 -->
  <string>wireless1688</string> <!-- 阿里巴巴 -->

  <!-- 社交、社区-->
  <string>weibo</string><!-- 微博 -->
  <string>zhihu</string><!-- 知乎 -->
  <string>xhsdiscover</string><!-- 小红书 -->
  <string>momochat</string><!-- 陌陌 -->
  <string>blued</string><!-- blued -->
  <string>mqzone</string><!-- QQ空间 -->
  <string>mqq</string><!-- QQ -->
  <string>tantanapp</string><!-- 探探 -->
  <string>huputiyu</string><!-- 虎扑 -->
  <string>com.baidu.tieba</string> <!-- 贴吧  -->
  <string>tianya</string> <!-- 天涯社区  -->
  <string>douban</string> <!-- 豆瓣 -->
  <string>jike</string> <!-- 即刻 -->

  <!-- 短视频 -->
  <string>snssdk1128</string> <!-- 抖音 -->
  <string>snssdk1112</string> <!-- 火山 -->
  <string>snssdk32</string> <!-- 西瓜视频 -->
  <string>gifshow</string> <!-- 快手 -->

  <!-- 视频/直播 -->
  <string>tenvideo</string> <!-- 腾讯视频  -->
  <string>youku</string> <!-- 优酷  -->
  <string>bilibili</string> <!-- B站  -->
  <string>imgotv</string> <!-- 芒果TV  -->
  <string>qiyi-iphone</string> <!-- 爱奇艺  -->
  <string>hanju</string> <!-- 韩剧TV  -->
  <string>douyutv</string> <!-- 斗鱼  -->
  <string>yykiwi</string> <!-- 虎牙  -->

  <!-- 图片处理  -->
  <string>mtxx.open</string> <!-- 美图秀秀  -->
  <string>faceu</string> <!-- faceu国内  -->
  <string>ulike</string> <!-- 轻颜国内 -->

  <!-- 资讯 -->
  <string>snssdk141</string> <!-- 今日头条  -->
  <string>newsapp</string> <!-- 网易新闻  -->
  <string>qqnews</string> <!-- 腾讯新闻  -->
  <string>iting</string> <!-- 喜马拉雅 -->
  <string>weread</string> <!-- 微信读书 -->
  <string>jianshu</string> <!-- 简书 -->
  <string>igetApp</string> <!-- 得到 -->
  <string>kuaikan</string> <!-- 快看漫画 -->

  <!-- 财经 -->
  <string>sinanews</string> <!-- 新浪财经  -->
  <string>amihexin</string> <!-- 同花顺炒股 -->

  <!-- 音乐 -->
  <string>orpheus</string> <!-- 网易云音乐  -->
  <string>qqmusic</string> <!-- qq音乐  -->
  <string>kugouURL</string> <!-- 酷狗  -->
  <string>qmkege</string> <!-- 全民K歌 -->
  <string>changba</string> <!-- 唱吧  -->

  <!-- 工具 -->
  <string>iosamap</string> <!-- 高德地图  -->
  <string>baidumap</string> <!-- 百度地图   -->
  <string>baiduyun</string> <!-- 百度网盘  -->
  <string>rm434209233MojiWeather</string> <!-- 墨迹天气  -->

  <!-- 办公 -->
  <string>wxwork</string> <!-- 企业微信  -->
  <string>dingtalk</string> <!-- 钉钉 -->


  <!-- 生活 -->
  <string>imeituan</string> <!-- 美团  -->
  <string>dianping</string> <!-- 点评  -->
  <string>cainiao</string> <!-- 菜鸟裹裹  -->
  <string>wbmain</string> <!--  58同城 -->
  <string>mihome</string> <!--  米家 -->

  <!-- 美食佳饮  -->
  <string>xcfapp</string> <!-- 下厨房  -->
  <string>sbuxcn</string> <!-- 星巴克中国  -->
  <string>meituanwaimai</string> <!-- 美团外卖  -->

  <!-- 运动健康  -->
  <string>fb370547106731052</string> <!-- 小米运动  -->
  <string>meetyou.linggan</string> <!-- 美柚  -->
  <string>babytree</string> <!-- 宝宝树  -->
  <string>keep</string> <!-- keep  -->

  <!-- 旅行  -->
  <string>CtripWireless</string> <!-- 携程  -->
  <string>diditaxi</string> <!-- 滴滴  -->
  <string>taobaotravel</string> <!-- 飞猪  -->
  <string>travelguide</string> <!-- 马蜂窝  -->



  <!-- 游戏 -->
  <string>tencent1104466820</string> <!-- 王者荣耀  -->
  <string>tencent100689805</string> <!-- 天天爱消除  -->
  <string>tencent382</string> <!-- QQ斗地主  -->
</array>
```



### 4.4 iOS14适配

由于iOS14中对于权限和隐私内容有一定程度的修改，而且和广告业务关系较大，请按照如下步骤适配，如果未适配。不会导致运行异常或者崩溃等情况，但是会一定程度上影响广告收入。详情请访问[https://developer.apple.com/documentation/apptrackingtransparency](https://developer.apple.com/documentation/apptrackingtransparency)。

1. 应用编译环境升级至 Xcode 12.0 及以上版本；
2. 升级莫比乌斯iOS SDK到 2.5.0及以上版本；
3. 设置SKAdNetwork和IDFA权限；

#### 4.4.1 SKAdNetwork

SKAdNetwork 是接收iOS端营销推广活动归因数据的一种方法。

将下列SKAdNetwork ID 添加到 Info.plist 中，以保证 SKAdNetwork 的正确运行。根据对接平台添加相应SKAdNetworkID，若无对接平台SKNetworkID则无需添加。

每个广告平台的SKAdNetwork ID都是固定值，直接复制并添加即可。

```xml
<key>SKAdNetworkItems</key>
<array>
  // 穿山甲
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>238da6jt44.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>x2jnk7ly8j.skadnetwork</string>
  </dict>
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>22mmun2rn5.skadnetwork</string>
  </dict>
  // 优量汇（广点通）
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>f7s53z58qe.skadnetwork</string>
  </dict>
  // Admob（谷歌广告）
  <dict>
    <key>SKAdNetworkIdentifier</key>
    <string>cstr6suwn9.skadnetwork</string>
  </dict>
</array>
```

#### 4.4.2 IDFA

从 iOS 14 开始，在应用程序调用 App Tracking Transparency 向用户提跟踪授权请求之前，IDFA 将不可用。

1. 更新 Info.plist，添加 NSUserTrackingUsageDescription 字段和自定义文案描述。

```
<key>NSUserTrackingUsageDescription</key>
<string>获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。</string>
```

文案建议：

- 获取标记权限向您提供更优质、安全的个性化服务及内容，未经同意我们不会用于其他目的；开启后，您也可以前往系统“设置-隐私”中随时关闭。
- 获取IDFA标记权限向您提供更优质、安全的个性化服务及内容；开启后，您也可以前往系统“设置-隐私 ”中随时关闭。

2. 向用户申请权限。

```objectivec
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>

- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
    [self requestAd];
  }];
}
```


## 5. 示例代码

### 5.1 SDK初始化

在 AppDelegate.m 中进行SDK的初始化

```objectivec
#import <AdKleinSDK/AdKleinSDK.h>

// 初始化莫比乌斯SDK
[AdKleinSDKConfig initMediaId:CONST_MEDIA_ID];
```

**PS ：mediaId通过后台配置生成，初始化必须在主线程中进行，SDK暂不支持多进程。**

#### 5.1.1 Admob的单独处理

接入Admob时，无法使用mediaId进行初始化来获取admob所需的`GADApplicationIdentifier`。

请更新应用的 `Info.plist` 文件以添加以下键：

一个字符串值为您的 AdMob 应用 ID 的 `GADApplicationIdentifier` 键（[在 AdMob 界面中标识](https://support.google.com/admob/answer/7356431)）

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>
```

同时请确认在步骤`4.4.1 SKAdNetwork`中配置了谷歌的SKAdNetworkID。



#### 5.1.2 调试模式

开启调试模式可以获得更详细的日志输出，用于定位问题。

```objectivec
[AdKleinSDKConfig debugMode];
// 初始化莫比乌斯SDK
[AdKleinSDKConfig initMediaId:CONST_MEDIA_ID];
```

#### 5.1.3 获取版本号

```objectivec
//SDK版本号，如：3.0.0
NSString *sdkVersion = [AdKleinSDKConfig sdkVersion];
//SDK数字版本号，如：30001 
NSString *sdkVersionCode = [AdKleinSDKConfig sdkVersionCode];
```



### <a name="ad_splash">5.2 开屏广告示例</a>

开屏广告建议在闪屏页进行展示，开屏广告的宽度和高度取决于容器的宽高，都是会撑满广告容器；**开屏广告的高度必须大于等于屏幕高度（手机屏幕完整高度，包括状态栏之类）的75%**，否则可能会影响收益计费（广点通的开屏甚至会影响跳过按钮的回调）。

1. 引入相关模块：

```objectivec
#import <AdKleinSDK/AdKleinSDKSplashAd.h>
```

2. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKSplashAd *splashAd;
```

3. 实现`AdKleinSDKSplashAdDelegate`相关回调：

```objectivec
- (void)ak_splashAdDidSkip:(AdKleinSDKSplashAd *)splashAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_splashAdTimeOver:(AdKleinSDKSplashAd *)splashAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_splashAdDidFail:(AdKleinSDKSplashAd *)splashAd withError:(NSError *)error {
    [self showError:error];
}
- (void)ak_splashAdDidLoad:(AdKleinSDKSplashAd *)splashAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_splashAdDidShow:(AdKleinSDKSplashAd *)splashAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_splashAdDidClick:(AdKleinSDKSplashAd *)splashAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_splashAdDidClose:(AdKleinSDKSplashAd *)splashAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
```

4. 执行广告加载器获取广告：

```objectivec
self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
self.window.rootViewController = [ViewController new];
[self.window makeKeyAndVisible];

self.splashAd = [[AdKleinSDKSplashAd alloc] initWithPlacementId:CONST_SPLASH_ID window:self.window];
self.splashAd.delegate = self;
[self.splashAd load];
```

#### 开屏广告优化建议

1. 第一步加载一个白底，带logo的图
2. 第二步给用户看隐私协议，点击同意
3. app做获取权限，获取相应权限后请求广告
4. 第四步还是 让用户看那个白底logo的图，等待2-3s加载广告
5. 第五步放开机引导页



### <a name="ad_banner">5.3 横幅广告示例</a>

Banner横幅广告建议放置在 **固定位置**，而非TableView等控件中充当Cell，Banner广告支持多种尺寸比例，可在后台创建广告位时配置，Banner广告的宽度将会撑满容器，高度自适应，建议Banner广告容器高度也为自适应。

1. 引入相关模块：

```objectivec
#import <AdKleinSDK/AdKleinSDKBannerAd.h>
```

2. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKBannerAd *bannerAd;
```

3. 实现`AdKleinSDKBannerAdDelegate`相关回调：

```objectivec
- (void)ak_bannerAdDidClose:(AdKleinSDKBannerAd *)bannerAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_bannerAdDidFail:(AdKleinSDKBannerAd *)bannerAd withError:(NSError *)error {
    [self showError:error];
}
- (void)ak_bannerAdDidLoad:(AdKleinSDKBannerAd *)bannerAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_bannerAdDidShow:(AdKleinSDKBannerAd *)bannerAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_bannerAdDidClick:(AdKleinSDKBannerAd *)bannerAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
```

4. 执行广告加载器获取广告：

```objectivec
  self.bannerAd = [[AdKleinSDKBannerAd alloc] initWithPlacementId:CONST_BANNER_ID viewController:self];
  self.bannerAd.delegate = self;
  self.bannerAd.bannerFrame =CGRectMake(0, 400, 375, 60);
  self.bannerAd.superView = self.view;
  self.bannerAd.animated = YES;
  [self.bannerAd load];
```



### <a name="ad_native">5.4 信息流广告示例</a>

信息流广告，具备自渲染和模板两种广告样式：自渲染是SDK将返回广告标题、描述、Icon、图片、多媒体视图等信息，开发者可通过自行拼装渲染成喜欢的样式；模板样式则是返回拼装好的广告视图，开发者只需将视图添加到相应容器即可，模板样式的容器高度建议是自适应。

#### 5.4.1 自渲染

1. 引入相关模块：

```objectivec
#import <AdKleinSDK/AdKleinSDKNativeAd.h>
```

2. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKNativeAd *adLoader;
```

3. 实现`AdKleinSDKNativeAdDelegate`相关回调，其中需要在加载成功回调中对拿到的广告视图进行渲染：

```objectivec
- (void)ak_nativeAdDidLoad:(AdKleinSDKNativeAd *)nativeAd withAdViews:(NSArray<__kindof UIView<AdKleinSDKNativeAdViewDelegate> *> *)adViews {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
  //    self.adViews = adViews;
  for (UIView<AdKleinSDKNativeAdViewDelegate> *adView in adViews) {
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = 300;
    adView.frame = CGRectMake(0, self.adY, width, height);
    adView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.9 alpha:0.3];
    [self.scrollView addSubview:adView];
    self.adY += height+20;
    self.scrollView.contentSize = CGSizeMake(width, self.adY+100);

    AdKleinSDKNativeAdData *nativeAdData = adView.data;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, width-30, 20)];
    title.text = nativeAdData.title;
    [adView addSubview:title];

    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, width-30, 40)];
    desc.text = nativeAdData.desc;
    [adView addSubview:desc];

    // 展示关闭按钮
    UIButton *closeButton = [UIButton new];
    [adView addSubview:closeButton];
    [adView bringSubviewToFront:closeButton];
    closeButton.frame = CGRectMake(width - 80, 0, 80, 44);
    [closeButton setTitle:@"remove" forState:UIControlStateNormal];
    [closeButton addTarget:adView action:@selector(ak_close) forControlEvents:UIControlEventTouchUpInside];

    NSLog(@"AdKleinSDKDemo: NativeAd Mode = %lu", (unsigned long)nativeAdData.imageMode);

    switch (nativeAdData.imageMode) {
      case AK_NATIVE_AD_LARGE_IMAGE:
        {
          UIImageView *single = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, width-30, 200)];
          [adView addSubview:single];
          single.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[0]]]];
          [adView ak_registViews:@[title, desc, single]];
        }
        break;
      case AK_NATIVE_AD_SMALL_IMAGE:
        {
          UIImageView *single = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, width-30, 200)];
          [adView addSubview:single];
          single.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[0]]]];
          [adView ak_registViews:@[title, desc, single]];
        }
        break;
      case AK_NATIVE_AD_THREE_SMALL:
        {
          CGFloat imageWidth = (width - 16) / 3;
          CGFloat imageRate = 228 / 150.0; // 三小图默认比例
          UIImageView *imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 84, imageWidth, imageWidth / imageRate)];
          UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(16 + imageWidth, 84, imageWidth, imageWidth / imageRate)];
          UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(24 + imageWidth * 2, 84, imageWidth, imageWidth / imageRate)];

          [adView addSubview:imageView0];
          [adView addSubview:imageView1];
          [adView addSubview:imageView2];
          imageView0.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[0]]]];
          imageView1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[1]]]];
          imageView2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[2]]]];
          [adView ak_registViews:@[title, desc, imageView0, imageView1, imageView2]];
        }
        break;
      case AK_NATIVE_AD_VIDEO:
        {
          UIView *video = adView.mediaView;
          video.frame = CGRectMake(15, 70, width-30, 200);
          [adView addSubview:video];
          [adView ak_registViews:@[title, desc, video]];
        }
        break;

      default:
        break;
    }
  }
}

- (void)ak_nativeAdDidFail:(AdKleinSDKNativeAd *)nativeAd withError:(NSError *)error {
  [self showError:error];
}
- (void)ak_nativeAdDidShow:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_nativeAdDidClick:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_nativeAdDidClose:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
```

**注意** 使用`ak_close`以外的方式移除广告视图前，需要执行`ak_unRegistView`方法，否则可能导致内存泄露。

```objectivec
for (id adView in self.adViews) {
  if([adView conformsToProtocol:@protocol(AdKleinSDKNativeAdViewDelegate)]) {
    // 取消注册
    [(id<AdKleinSDKNativeAdViewDelegate>)adView ak_unRegistView];
  }
}
```

4. 执行广告加载器获取广告：

- 信息流广告加载器支持重复load。

```objectivec
if(!self.adLoader) {
  self.adLoader = [[AdKleinSDKNativeAd alloc] initWithPlacementId:CONST_FEED_NATIVE_ID viewController:self];
  self.adLoader.delegate = self;
  self.adLoader.adCount = 3;
}
[self.adLoader load];
```



#### 5.4.2 模版渲染

1. 引入相关模块：

```objectivec
#import <AdKleinSDK/AdKleinSDKNativeExpressAd.h>
```

2. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKNativeExpressAd *adLoader;
```

3. 实现`AdKleinSDKNativeExpressAdDelegate`相关回调：

- 在加载成功回调中对广告视图执行render方法以进行模板渲染。
- 在渲染成功回调中再将广告视图加入列表进行展现，因为此时才能获取真实的高度。

```objectivec
- (void)ak_nativeExpressAdDidLoad:(AdKleinSDKNativeExpressAd *)nativeAd withAdViews:(NSArray<__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *> *)adViews {
  // 将获取到的广告视图进行模板渲染
  [adViews enumerateObjectsUsingBlock:^(UIView<AdKleinSDKNativeExpressAdViewDelegate> *adView, NSUInteger idx, BOOL * _Nonnull stop) {
    [adView render];
  }];

  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}

- (void)ak_nativeExpressAdDidFail:(AdKleinSDKNativeExpressAd *)nativeAd withError:(NSError *)error {
  [self showError:error];
}
- (void)ak_nativeExpressAdDidRenderSuccess:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
  // 渲染成功才能拿到真实的高度
  dispatch_async(dispatch_get_main_queue(), ^{
    for (int i = 0; i < 6; i ++) {
      [self.dataArray addObject:[NSNull null]];
    }
    [self.dataArray addObject:adView];
    [self.tableView reloadData];
  });

  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_nativeExpressAdDidRenderFail:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_nativeExpressAdDidShow:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_nativeExpressAdDidClick:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_nativeExpressAdDidClose:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
  [adView removeFromSuperview];
  [self.dataArray removeObject:adView];
  [self.tableView reloadData];

  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}

```

4. 执行广告加载器获取广告：

- 信息流广告加载器支持重复load。
- 模板信息流的adSize只有宽度设置有效，高度会由模板渲染自适应。

```objectivec
if (!self.adLoader) {
  self.adSize = CGSizeMake(self.view.frame.size.width, 0);

  self.adLoader = [[AdKleinSDKNativeExpressAd alloc] initWithPlacementId:CONST_FEED_EXPRESS_ID viewController:self];
  self.adLoader.delegate = self;
  self.adLoader.adSize = self.adSize;
  self.adLoader.adCount = 3;
}

[self.adLoader load];
```

### <a name="ad_reward_video">5.5 激励视频广告示例</a>

将短视频融入到APP场景当中，用户观看短视频广告后可以给予一些应用内奖励。

1. 引入相关模块：

```objectivec
#import <AdKleinSDK/AdKleinSDKRewardVideoAd.h>
```

2. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKRewardVideoAd *adLoader;
```

3. 实现`AdKleinSDKRewardVideoAdDelegate`相关回调：

```objectivec
- (void)ak_rewardVideoAdDidClose:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}

- (void)ak_rewardVideoAdDidComplete:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}

- (void)ak_rewardVideoAdDidSkip:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}

- (void)ak_rewardVideoAdDidFail:(AdKleinSDKRewardVideoAd *)rewardVideoAd withError:(NSError *)error {
  [self showError:error];
}

- (void)ak_rewardVideoAdDidLoad:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}

- (void)ak_rewardVideoAdDidDownload:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
  // 此处仅为示例用，表明在广告下载完之后才能执行展现，实际使用时建议提前加载视频，以提升用户体验
  [self.adView show];
}

- (void)ak_rewardVideoAdDidShow:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}

- (void)ak_rewardVideoAdDidClick:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
```

4. 执行广告加载器获取广告：

```objectivec
self.adLoader = [[AdKleinSDKRewardVideoAd alloc] initWithPlacementId:CONST_REWARD_VIDEO_ID viewController:self];
self.adLoader.delegate = self;
[self.adLoader load];
```



### <a name="ad_fullscreen_video">5.6 全屏视频广告示例</a>

全屏视频广告是类似激励视频样式的广告形式，与激励视频不同之处在于全屏视频广告播放一定时间时间后即可跳过，同时全屏视频广告拥有跳过回调不具备奖励回调。

1. 引入相关模块：

```objectivec
#import <AdKleinSDK/AdKleinSDKFullScreenVideoAd.h>
```

2. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKFullScreenVideoAd *adLoader;
```

3. 实现`AdKleinSDKFullScreenVideoAdDelegate`相关回调：

```objectivec
- (void)ak_fullScreenVideoAdDidClose:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_fullScreenVideoAdDidComplete:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_fullScreenVideoAdDidSkip:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_fullScreenVideoAdDidFail:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd withError:(NSError *)error{
    [self showError:error];
}
- (void)ak_fullScreenVideoAdDidLoad:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_fullScreenVideoAdDidShow:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_fullScreenVideoAdDidClick:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
```

4. 执行广告加载器获取广告：

```objectivec
self.adLoader = [[AdKleinSDKFullScreenVideoAd alloc] initWithPlacementId:CONST_FULLSCREEN_ID viewController:self];
self.adLoader.delegate = self;
self.adLoader.detailPageVideoMuted = YES;
self.adLoader.videoAutoPlayOnWWAN = YES;
self.adLoader.minVideoDuration = 5;
self.adLoader.maxVideoDuration = 100*1000;
[self.adLoader load];
```



### <a name="ad_interstitial">5.7 插屏广告示例</a>

插屏广告是移动广告的一种常见形式，在应用流程中弹出，当应用展示插屏广告时，用户可以选择点击广告，也可以将其关闭并返回应用。

1. 引入相关模块：

```objectivec
#import <AdKleinSDK/AdKleinSDKInterstitialAd.h>
```

2. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKInterstitialAd *adLoader;
```

3. 实现`AdKleinSDKInterstitialAdDelegate`相关回调：

```objectivec
- (void)ak_interstitialAdDidClose:(AdKleinSDKInterstitialAd *)interstitialAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_interstitialAdDidRenderFail:(AdKleinSDKInterstitialAd *)interstitialAd withError:(NSError *)error {
  [self showError:error];
}
- (void)ak_interstitialAdDidRenderSuccess:(AdKleinSDKInterstitialAd *)interstitialAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_interstitialAdDidFail:(AdKleinSDKInterstitialAd *)interstitialAd withError:(NSError *)error {
  [self showError:error];
}
- (void)ak_interstitialAdDidLoad:(AdKleinSDKInterstitialAd *)interstitialAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
  // 此处仅为示例用，表明在广告下载完之后才能执行展现，实际使用时建议提前加载广告，以提升用户体验
  [self.adView show];
}
- (void)ak_interstitialAdDidShow:(AdKleinSDKInterstitialAd *)interstitialAd {
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
- (void)ak_interstitialAdDidClick:(AdKleinSDKInterstitialAd *)interstitialAd{
  NSString *func = [NSString stringWithFormat:@"%s",__func__];
  [self showString:func];
}
```

4. 执行广告加载器获取广告：

```objectivec
self.adLoader = [[AdKleinSDKInterstitialAd alloc] initWithPlacementId:CONST_INTERSTITIAL_ID viewController:self];
self.adLoader.delegate = self;
self.adLoader.adSize = CGSizeMake(300, 400);
[self.adLoader load];
```



## 6. iOS集成常见问题

### 6.1 通用问题

#### 1：为什么返回的广告中有重复广告？

A：同一个广告主在广告后台会使用相似的素材内容创建多个广告计划，因此平台在返回的广告中可能会有很多相似内容的广告，但是这些广告对应的广告计划ID是不相同的。

### 6.2 开屏广告常见问题

#### 1.开屏广告的容器需要注意什么？

A：**开屏广告的高度必须大于等于屏幕高度（手机屏幕完整高度，包括状态栏）的75%**，否则可能会影响收益计费（广点通的开屏甚至会影响跳过按钮的回调）。

### 6.3 横幅广告常见问题

#### 1.Banner横幅广告的尺寸问题？

A：Banner广告支持多种尺寸比例，可在后台创建广告位时配置，Banner广告的宽度将会撑满容器，高度自适应，建议Banner广告容器高度也为自适应。

#### 2.Banner横幅广告的建议位置

A：Banner横幅广告建议放置在 **固定位置**，而非TableView等控件中充当Cell。

### 6.4 信息流广告常见问题

#### 1.信息流广告中自渲染和模板的区别

A：信息流广告，具备自渲染和模板两种广告样式：自渲染是SDK将返回广告标题、描述、Icon、图片、多媒体视图等信息，开发者可通过自行拼装渲染成喜欢的样式；模板样式则是返回拼装好的广告视图，开发者只需将视图添加到相应容器即可，模板样式的容器高度建议是自适应

### 6.5 激励视频、全屏视频、插屏广告常见问题

A:**激励视频广告**是播放一段视频，播放完成或其他特定情况下（不同平台有所差异）会给予激励回调，激励视频一般是需要播放完成后才能退出播放界面；**全屏视频广告**类似激励视频，但是全屏视频没有激励回调，全屏视频一般在播放一段时间后即可退出当前播放界面；**插屏广告**一般是以弹窗的形式展示图文或视频，也有部分平台是单独的全屏界面进行展示；



## 7. iOS SDK错误码



| 错误码 |               描述               | 排查方向                                                     |
| ------ | :------------------------------: | ------------------------------------------------------------ |
| 1001   |           mediaId为空            |                                                              |
| 1002   |            无可用上游            | 检查应用和广告位是否配置正确且通过审核                       |
| 1003   |          初始化上游异常          |                                                              |
| 2000   |   上游初始化失败，无法加载广告   |                                                              |
| 2001   | 广告配置未加载完成或加载出现错误 |                                                              |
| 2002   |          广告位加载异常          |                                                              |
| 2003   |      无可用的上游广告位配置      | 通过之前的日志检查是否所有上游都加载失败，或未获取到有效的广告位配置 |
| 2004   |        无匹配的上游适配器        |                                                              |
| 2005   |         加载广告配置超时         |                                                              |
|        |                                  |                                                              |



## 更新日志

| 版本号  |    日期    | 更新日志                                                     |
| ------- | :--------: | ------------------------------------------------------------ |
| V3.0.1 | 2021-06-25 | 3.0全新发布，产品更名为AdKleinSDK，支持Cocoapods在线安装，2.x版本用户请注意接入代码更新； |
