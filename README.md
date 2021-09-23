# AdKleinSDK iOS SDK——接入文档

## 概述

尊敬的开发者朋友，欢迎您使用AdKlein广告聚合SDK。通过本文档，您可以快速完成多平台广告SDK的集成。

### AdKlein广告聚合SDK组成结构

AdKlein广告聚合SDK主要由**AdKlein核心SDK**（简称AdKleinSDK）和**一个或多个**三方广告平台SDK构成。

### 三方广告平台名称概述

| Name      | 平台名称   | 平台别称 |
| --------- | -------- | -------- |
| mobius    | 莫比乌斯   | 莫比乌斯 |
| gdt       | 广点通   | 优量汇   |
| toutiao   | 头条     | 穿山甲   |
| baidu     | 百度     | 百青藤   |
| admob   | AdMob    | 谷歌     |
| smaato | Smaato | 誉广 |


## 支持的广告类型

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

## Demo下载链接

[Github](https://github.com/iusmob/AdKleinSDKDemo-iOS)

## SDK接入流程

### pod 接入 [强烈推荐]

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

### 手动导入

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

### 工程环境配置

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



### iOS14适配

由于iOS14中对于权限和隐私内容有一定程度的修改，而且和广告业务关系较大，请按照如下步骤适配，如果未适配。不会导致运行异常或者崩溃等情况，但是会一定程度上影响广告收入。详情请访问[https://developer.apple.com/documentation/apptrackingtransparency](https://developer.apple.com/documentation/apptrackingtransparency)。

1. 应用编译环境升级至 Xcode 12.0 及以上版本；
2. 升级AdKleinSDK-iOS SDK到 2.5.0及以上版本；
3. 设置SKAdNetwork和IDFA权限；

#### SKAdNetwork

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

#### IDFA

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
  }];
}
```

```swift
import AppTrackingTransparency
import AdSupport

func requestIDFA {
  ATTrackingManager.requestTrackingAuthorization(completionHandler: {
  })
}
```

**注意：** 申请权限的回调方法不在主线程，不可直接进行SDK的初始化和广告加载。



## 示例代码

### 引入SDK模块

```objectivec
#import <AdKleinSDK/AdKleinSDK.h>
```

```swift
import AdKleinSDK
```

### SDK初始化

在 AppDelegate.m 中进行SDK的初始化

```objectivec
[AdKleinSDKConfig initMediaId:CONST_MEDIA_ID];
```

```swift
AdKleinSDKConfig.initMediaId(Constant.MEDIA_ID)
```

**注意：**mediaId需要在运营平台上创建并获取。

#### Admob的单独处理

接入Admob时，无法使用mediaId进行初始化来获取admob所需的`GADApplicationIdentifier`。

请更新应用的 `Info.plist` 文件以添加以下键：

一个字符串值为您的 AdMob 应用 ID 的 `GADApplicationIdentifier` 键（[在 AdMob 界面中标识](https://support.google.com/admob/answer/7356431)）

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>
```

同时请确认在步骤[`SKAdNetwork`](#skadnetwork)中配置了谷歌的SKAdNetworkID。



#### 调试模式

开启调试模式可以获得更详细的日志输出，用于定位问题。

```objectivec
[AdKleinSDKConfig debugMode];
// 初始化AdKleinSDK
[AdKleinSDKConfig initMediaId:CONST_MEDIA_ID];
```

```swift
AdKleinSDKConfig.debugMode()
// 初始化AdKleinSDK
AdKleinSDKConfig.initMediaId(Constant.MEDIA_ID)
```



#### 获取版本号

```objectivec
//SDK版本号，如：3.0.0
NSString *sdkVersion = [AdKleinSDKConfig sdkVersion];
//SDK数字版本号，如：30001 
NSString *sdkVersionCode = [AdKleinSDKConfig sdkVersionCode];
```

```swift
//SDK版本号，如：3.0.0
let sdkVersion = AdKleinSDKConfig.sdkVersion()
//SDK数字版本号，如：30001 
let sdkVersionCode = AdKleinSDKConfig.sdkVersionCode()
```



### <a name="ad_splash">开屏广告示例</a>

开屏广告建议在闪屏页进行展示，开屏广告的宽度和高度取决于容器的宽高，都是会撑满广告容器；**开屏广告的高度必须大于等于屏幕高度（手机屏幕完整高度，包括状态栏之类）的75%**，否则可能会影响收益计费（广点通的开屏甚至会影响跳过按钮的回调）。

1. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKSplashAd *adLoader;
```

```swift
var adLoader: AdKleinSDKSplashAd?
```


2. 实现`AdKleinSDKSplashAdDelegate`相关回调：

```objectivec
/**
 广告拉取成功
 @param splashAd 广告加载器实例
*/
- (void)ak_splashAdDidLoad:(AdKleinSDKSplashAd *)splashAd {
}
/**
 广告拉取失败
 @param splashAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_splashAdDidFail:(AdKleinSDKSplashAd *)splashAd withError:(NSError *)error {
}
/**
 广告展示
 @param splashAd 广告加载器实例
*/
- (void)ak_splashAdDidShow:(AdKleinSDKSplashAd *)splashAd {
}
/**
 广告点击
 @param splashAd 广告加载器实例
*/
- (void)ak_splashAdDidClick:(AdKleinSDKSplashAd *)splashAd {
}
/**
 广告关闭
 @param splashAd 广告加载器实例
*/
- (void)ak_splashAdDidClose:(AdKleinSDKSplashAd *)splashAd {
}
/**
 点击跳过
 @param splashAd 广告加载器实例
*/
- (void)ak_splashAdDidSkip:(AdKleinSDKSplashAd *)splashAd {
}
/**
 倒计时结束
 @param splashAd 广告加载器实例
*/
- (void)ak_splashAdTimeOver:(AdKleinSDKSplashAd *)splashAd {
}
```
```swift
/**
 广告拉取成功
 @param splashAd 广告加载器实例
*/
func ak_splashAdDidLoad(_ splashAd: AdKleinSDKSplashAd) {
}
/**
 广告拉取失败
 @param splashAd 广告加载器实例
 @param error 错误描述
*/
func ak_splashAdDidFail(_ splashAd: AdKleinSDKSplashAd, withError error: Error) {
}
/**
 广告展示
 @param splashAd 广告加载器实例
*/
func ak_splashAdDidShow(_ splashAd: AdKleinSDKSplashAd) {
}
/**
 广告点击
 @param splashAd 广告加载器实例
*/
func ak_splashAdDidClick(_ splashAd: AdKleinSDKSplashAd) {
}
/**
 广告关闭
 @param splashAd 广告加载器实例
*/
func ak_splashAdDidClose(_ splashAd: AdKleinSDKSplashAd) {
}
/**
 点击跳过
 @param splashAd 广告加载器实例
*/
func ak_splashAdDidSkip(_ splashAd: AdKleinSDKSplashAd) {
}
/**
 倒计时结束
 @param splashAd 广告加载器实例
*/
func ak_splashAdTimeOver(_ splashAd: AdKleinSDKSplashAd) {
}
```

3. 执行广告加载器获取广告：

```objectivec
self.adLoader = [[AdKleinSDKSplashAd alloc] initWithPlacementId:CONST_SPLASH_ID window:self.window];
self.adLoader.delegate = self;
[self.adLoader load];
```

```swift
adLoader = AdKleinSDKSplashAd(placementId: Constant.SPLASH_ID, window: window!)
adLoader?.delegate = self
adLoader?.load()
```

**注意：**开屏广告在展示结束前需要用本地变量存储以避免提前释放导致异常。

#### 自定义底部View

```objectivec
_bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,[UIScreen mainScreen].bounds.size.height*0.25)];
_bottomView.image = [UIImage imageNamed:@"bottom"];
_bottomView.contentMode = UIViewContentModeScaleAspectFill;
self.adLoader.bottomView = _bottomView;
```
```swift
bottomView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constant.ScreenWidth, height: Constant.ScreenHeight * 0.25))
bottomView?.image = UIImage(named: "bottom")
bottomView?.contentMode = .scaleAspectFill
adLoader?.bottomView = bottomView
```

**注意：** 目前仅穿山甲、广点通、莫比乌斯支持该功能。

#### 自定义跳过按钮

```objectivec
_skipView = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 80, [[UIScreen mainScreen] bounds].size.height - 80, 60, 30)];
[_skipView addTarget:self action:@selector(skipViewClick) forControlEvents:UIControlEventTouchUpInside];
[_skipView setTitle:@"跳过" forState:UIControlStateNormal];
[_skipView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
[_skipView.layer setCornerRadius:15.0];
_skipView.titleLabel.font = [UIFont systemFontOfSize: 14.0];
_skipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
self.adLoader.skipView = self.skipView;
```

```swift
skipView = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - 80, y: UIScreen.main.bounds.size.height - 80, width: 60, height: 30))
skipView?.addTarget(self, action: #selector(self.skipViewClick), for: .touchUpInside)
skipView?.setTitle("跳过", for: .normal)
skipView?.setTitleColor(UIColor.white, for: .normal)
skipView?.layer.cornerRadius = 15.0
skipView?.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
skipView?.backgroundColor = UIColor.black.withAlphaComponent(0.7)
adLoader?.skipView = skipView
```

**注意：** 目前仅穿山甲、莫比乌斯支持该功能。

#### 开屏广告优化建议

可参考Demo中的实现。

1. 先加载底图，避免首屏先于开屏广告被用户看到。
2. 如果是首次启动，弹出隐私协议窗口，等待用户点击；用户点击同意后，继续申请获取IDFA。
3. 初始化SDK并请求开屏广告。
4. 在开屏加载失败、展现回调中移除底图，此时首页可见。



### <a name="ad_banner">横幅广告示例</a>

Banner横幅广告建议放置在 **固定位置**，而非TableView等控件中充当Cell，Banner广告支持多种尺寸比例，可在后台创建广告位时配置。

**注意** 接入方式在3.2.0后有所变化，现在横幅广告加载器即广告视图，可以直接设置frame并添加到页面中。AdKleinSDK版本从<3.2.0升级时，需要进行以下改动：

- 将`AdKleinSDKBannerAd`改名为`AdKleinSDKBannerAdView`，将`AdKleinSDKBannerAdDelegate`改名为`AdKleinSDKBannerAdViewDelegate`
- 将`self.bannerAd.bannerFrame`改为`self.bannerAd.frame`
- 将`self.bannerAd.adContainer = self.view;`改为`[self.view addSubview:self.bannerAd];`



1. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKBannerAdView *bannerAd;
```

```swift
var bannerAd: AdKleinSDKBannerAdView?
```

2. 实现`AdKleinSDKBannerAdViewDelegate`相关回调：

```objectivec
/**
 广告拉取成功
 @param bannerAd 广告加载器实例
*/
- (void)ak_bannerAdDidLoad:(AdKleinSDKBannerAdView *)bannerAd {
}
/**
 广告拉取失败
 @param bannerAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_bannerAdDidFail:(AdKleinSDKBannerAdView *)bannerAd withError:(NSError *)error {
}
/**
 广告展示
 @param bannerAd 广告加载器实例
*/
- (void)ak_bannerAdDidShow:(AdKleinSDKBannerAdView *)bannerAd {
}
/**
 广告点击
 @param bannerAd 广告加载器实例
*/
- (void)ak_bannerAdDidClick:(AdKleinSDKBannerAdView *)bannerAd {
}
/**
 广告关闭
 @param bannerAd 广告加载器实例
*/
- (void)ak_bannerAdDidClose:(AdKleinSDKBannerAdView *)bannerAd {
}
```
```swift
/**
 广告拉取成功
 @param bannerAd 广告加载器实例
*/
func ak_bannerAdDidLoad(_ bannerAd: AdKleinSDKBannerAdView) {
}
/**
 广告拉取失败
 @param bannerAd 广告加载器实例
 @param error 错误描述
*/
func ak_bannerAdDidFail(_ bannerAd: AdKleinSDKBannerAdView, withError error: Error) {
}
/**
 广告展示
 @param bannerAd 广告加载器实例
*/
func ak_bannerAdDidShow(_ bannerAd: AdKleinSDKBannerAdView) {
}
/**
 广告点击
 @param bannerAd 广告加载器实例
*/
func ak_bannerAdDidClick(_ bannerAd: AdKleinSDKBannerAdView) {
}
/**
 广告关闭
 @param bannerAd 广告加载器实例
*/
func ak_bannerAdDidClose(_ bannerAd: AdKleinSDKBannerAdView) {
}
```


3. 执行广告加载器获取广告：

```objectivec
self.bannerAd = [[AdKleinSDKBannerAdView alloc] initWithPlacementId:CONST_BANNER_ID viewController:self];
self.bannerAd.delegate = self;
self.bannerAd.frame =CGRectMake(0, 400, 375, 60);
self.bannerAd.animated = YES; // 仅部分上游支持
[self.view addSubview:self.bannerAd]; 
[self.bannerAd load];
```

```swift
bannerAd = AdKleinSDKBannerAdView(placementId: Constant.BANNER_ID, viewController: self)
bannerAd?.delegate = self
bannerAd?.frame = CGRect(x: 0, y: 400, width: 375, height: 60)
bannerAd?.animated = true // 仅部分上游支持
view.addSubview(bannerAd!)
bannerAd?.load()
```



### <a name="ad_native">信息流广告示例</a>

信息流广告，具备自渲染和模板两种广告样式：自渲染是SDK将返回广告标题、描述、Icon、图片、多媒体视图等信息，开发者可通过自行拼装渲染成喜欢的样式；模板样式则是返回拼装好的广告视图，开发者只需将视图添加到相应容器即可，模板样式的容器高度建议是自适应。

#### 自渲染

1. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKNativeAd *adLoader;
```

```swift
var adLoader: AdKleinSDKNativeAd?
```

2. 实现`AdKleinSDKNativeAdDelegate`相关回调，其中需要在加载成功回调中对拿到的广告视图进行渲染：

```objectivec
/**
 广告拉取成功
 获取到广告view后，需要根据data数据进行自渲染
 @param nativeAd 广告加载器实例
 @param adViews 自渲染广告视图数组
*/
- (void)ak_nativeAdDidLoad:(AdKleinSDKNativeAd *)nativeAd withAdViews:(NSArray<__kindof UIView<AdKleinSDKNativeAdViewDelegate> *> *)adViews {
  for (UIView<AdKleinSDKNativeAdViewDelegate> *adView in adViews) {
    [self.adViews addObject:adView];
    
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

    switch (nativeAdData.imageMode) {
      case AK_NATIVE_AD_LARGE_IMAGE: // 大图
        {
          UIImageView *single = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, width-30, 200)];
          [adView addSubview:single];
          single.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[0]]]];
          [adView ak_registViews:@[title, desc, single]];
        }
        break;
      case AK_NATIVE_AD_SMALL_IMAGE: // 小图
        {
          UIImageView *single = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, width-30, 200)];
          [adView addSubview:single];
          single.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[0]]]];
          [adView ak_registViews:@[title, desc, single]];
        }
        break;
      case AK_NATIVE_AD_THREE_SMALL: // 三图
        {
          CGFloat imageWidth = (width - 16) / 3;
          CGFloat imageRate = 228 / 150.0;
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
      case AK_NATIVE_AD_VIDEO: // 视频
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
/**
 广告拉取失败
 @param nativeAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_nativeAdDidFail:(AdKleinSDKNativeAd *)nativeAd withError:(NSError *)error {
}
/**
 广告展示
 @param nativeAd 广告加载器实例
 @param adView 自渲染广告视图
 */
- (void)ak_nativeAdDidShow:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
}
/**
 广告点击
 @param nativeAd 广告加载器实例
 @param adView 自渲染广告视图
 */
- (void)ak_nativeAdDidClick:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
}
/**
 广告关闭
 @param nativeAd 广告加载器实例
 @param adView 自渲染广告视图
 */
- (void)ak_nativeAdDidClose:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
  [self.adViews removeObject:adView];
}
```

```swift
/**
 广告拉取成功
 获取到广告view后，需要根据data数据进行自渲染
 @param nativeAd 广告加载器实例
 @param adViews 自渲染广告视图数组
*/
func ak_nativeAdDidLoad(_ nativeAd: AdKleinSDKNativeAd, withAdViews adViews: [UIView & AdKleinSDKNativeAdViewDelegate]){
  // 将获取到的广告视图进行模板渲染
  for adView in adViews {
    self.adViews.append(adView)

    let width = Constant.ScreenWidth
    let height: CGFloat = 300
    adView.frame = CGRect(x: 0, y: adY, width: width, height: height)
    adView.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.9, alpha: 0.3)
    scrollView?.addSubview(adView)
    adY += height + 20
    scrollView?.contentSize = CGSize(width: width, height: adY + 100)

    let nativeAdData = adView.data
    let title = UILabel(frame: CGRect(x: 15, y: 0, width: width - 30, height: 20))
    title.text = nativeAdData.title
    adView.addSubview(title)

    let desc = UILabel(frame: CGRect(x: 15, y: 30, width: width - 30, height: 40))
    desc.text = nativeAdData.desc
    adView.addSubview(desc)

    // 展示关闭按钮
    let closeButton = UIButton()
    adView.addSubview(closeButton)
    adView.bringSubviewToFront(closeButton)
    closeButton.frame = CGRect(x: width - 80, y: 0, width: 80, height: 44)
    closeButton.setTitle("remove", for: .normal)
    closeButton.addTarget(adView, action: #selector(AdKleinSDKNativeAdViewDelegate.ak_close), for: .touchUpInside)

    switch nativeAdData.imageMode {
      case AK_NATIVE_AD_TYPE.LARGE_IMAGE: // 大图
      let single = UIImageView(frame: CGRect(x: 15, y: 70, width: width - 30, height: 200))
      adView.addSubview(single)

      let url : URL = URL.init(string: nativeAdData.images![0])!
      let data : NSData! = NSData(contentsOf: url)
      if data != nil {
        single.image = UIImage(data: data as Data)
      }

      adView.ak_registViews([title, desc, single])
      break
      case AK_NATIVE_AD_TYPE.SMALL_IMAGE: // 小图
      let single = UIImageView(frame: CGRect(x: 15, y: 70, width: width - 30, height: 200))
      adView.addSubview(single)

      let url = URL.init(string: nativeAdData.images![0])!
      let data = NSData(contentsOf: url)
      if data != nil {
        single.image = UIImage(data: data! as Data)
      }

      adView.ak_registViews([title, desc, single])
      break
      case AK_NATIVE_AD_TYPE.THREE_SMALL: // 三图
      let imageWidth: CGFloat = (width - 16) / 3
      let imageRate: CGFloat = 228 / 150.0
      let imageView0 = UIImageView(frame: CGRect(x: 8, y: 84, width: imageWidth, height: imageWidth / imageRate))
      let imageView1 = UIImageView(frame: CGRect(x: 16 + imageWidth, y: 84, width: imageWidth, height: imageWidth / imageRate))
      let imageView2 = UIImageView(frame: CGRect(x: 24 + imageWidth * 2, y: 84, width: imageWidth, height: imageWidth / imageRate))

      let url0 = URL.init(string: nativeAdData.images![0])!
      let data0 = NSData(contentsOf: url0)
      if data0 != nil {
        imageView0.image = UIImage(data: data0! as Data)
      }
      let url1 = URL.init(string: nativeAdData.images![1])!
      let data1 = NSData(contentsOf: url1)
      if data1 != nil {
        imageView1.image = UIImage(data: data1! as Data)
      }
      let url2 = URL.init(string: nativeAdData.images![2])!
      let data2 = NSData(contentsOf: url2)
      if data2 != nil {
        imageView2.image = UIImage(data: data2! as Data)
      }

      adView.ak_registViews([title, desc, imageView0, imageView1, imageView2])
      break
      case AK_NATIVE_AD_TYPE.VIDEO: // 视频
      let video = adView.mediaView
      video.frame = CGRect(x: 15, y: 70, width: width - 30, height: 200)
      adView.addSubview(video)
      adView.ak_registViews([title, desc, video])
      break
      default:
      break
    }
  }
}
/**
 广告拉取失败
 @param nativeAd 广告加载器实例
 @param error 错误描述
*/
func ak_nativeAdDidFail(_ nativeAd: AdKleinSDKNativeAd, withError error: Error) {
}
/**
 广告展示
 @param nativeAd 广告加载器实例
 @param adView 自渲染广告视图
 */
func ak_nativeAdDidShow(_ nativeAd: AdKleinSDKNativeAd, adView: UIView & AdKleinSDKNativeAdViewDelegate){
}
/**
 广告点击
 @param nativeAd 广告加载器实例
 @param adView 自渲染广告视图
 */
func ak_nativeAdDidClick(_ nativeAd: AdKleinSDKNativeAd, adView: UIView & AdKleinSDKNativeAdViewDelegate){
}
/**
 广告关闭
 @param nativeAd 广告加载器实例
 @param adView 自渲染广告视图
 */
func ak_nativeAdDidClose(_ nativeAd: AdKleinSDKNativeAd, adView: UIView & AdKleinSDKNativeAdViewDelegate){
  adViews.removeAll{$0 == adView}
}
```

**注意** 使用`ak_close`以外的方式移除广告视图前，需要执行`ak_unRegistView`方法，否则可能导致内存泄露。

```objectivec
for (id adView in self.adViews) {
  if([adView conformsToProtocol:@protocol(AdKleinSDKNativeAdViewDelegate)]) {
    // 取消注册
    [(id<AdKleinSDKNativeAdViewDelegate>)adView ak_unRegistView];
    [adView removeFromSuperview];
  }
}
```

```swift
for adView in adViews {
  if adView is AdKleinSDKNativeAdViewDelegate {
    // 取消注册
    (adView as? AdKleinSDKNativeAdViewDelegate)?.ak_unRegistView()
    adView.removeFromSuperview()
  }
}
```



3. 执行广告加载器获取广告：

- 信息流广告加载器支持重复load。

```objectivec
if(!self.adLoader) {
  self.adLoader = [[AdKleinSDKNativeAd alloc] initWithPlacementId:CONST_FEED_NATIVE_ID viewController:self];
  self.adLoader.delegate = self;
  self.adLoader.adCount = 3;
}
[self.adLoader load];
```

```swift
if (adLoader == nil) {
  adLoader = AdKleinSDKNativeAd(placementId: Constant.NATIVE_ID, viewController: self)
  adLoader?.delegate = self
  adLoader?.adCount = 3
}
adLoader?.load()
```



#### 模版渲染

1. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKNativeExpressAd *adLoader;
```
```swift
var adLoader: AdKleinSDKNativeExpressAd?
```

2. 实现`AdKleinSDKNativeExpressAdDelegate`相关回调：

- 在加载成功回调中对广告视图执行render方法以进行模板渲染。
- 在渲染成功回调中再将广告视图加入列表进行展现，因为此时才能获取真实的高度。

```objectivec
/**
 广告拉取成功
 获取到广告view后，需要执行render方法进行渲染
 @param nativeExpressAd 广告加载器实例
 @param adViews 模板广告视图数组
*/
- (void)ak_nativeExpressAdDidLoad:(AdKleinSDKNativeExpressAd *)nativeAd withAdViews:(NSArray<__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *> *)adViews {
  // 将获取到的广告视图进行模板渲染
  [adViews enumerateObjectsUsingBlock:^(UIView<AdKleinSDKNativeExpressAdViewDelegate> *adView, NSUInteger idx, BOOL * _Nonnull stop) {
    [adView render];
  }];
}
/**
 广告拉取失败
 @param nativeExpressAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_nativeExpressAdDidFail:(AdKleinSDKNativeExpressAd *)nativeAd withError:(NSError *)error {
}
/**
 广告渲染成功
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
- (void)ak_nativeExpressAdDidRenderSuccess:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
  // 渲染成功才能拿到真实的高度
  dispatch_async(dispatch_get_main_queue(), ^{
    for (int i = 0; i < 6; i ++) {
      [self.dataArray addObject:[NSNull null]];
    }
    [self.dataArray addObject:adView];
    [self.tableView reloadData];
  });
}
/**
 广告渲染失败
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
- (void)ak_nativeExpressAdDidRenderFail:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
}
/**
 广告展现
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
- (void)ak_nativeExpressAdDidShow:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
}
/**
 广告点击
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
- (void)ak_nativeExpressAdDidClick:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
}
/**
 广告关闭
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
- (void)ak_nativeExpressAdDidClose:(AdKleinSDKNativeExpressAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeExpressAdViewDelegate> *)adView {
  [adView removeFromSuperview];
  [self.dataArray removeObject:adView];
  [self.tableView reloadData];
}

```

```swift
/**
 广告拉取成功
 获取到广告view后，需要执行render方法进行渲染
 @param nativeExpressAd 广告加载器实例
 @param adViews 模板广告视图数组
*/
func ak_nativeExpressAdDidLoad(_ nativeAd: AdKleinSDKNativeExpressAd, withAdViews adViews: [UIView & AdKleinSDKNativeExpressAdViewDelegate]){
  // 将获取到的广告视图进行模板渲染
  for adView in adViews {
    adView.render()
  }
}
/**
 广告拉取失败
 @param nativeExpressAd 广告加载器实例
 @param error 错误描述
*/
func ak_nativeExpressAdDidFail(_ nativeAd: AdKleinSDKNativeExpressAd, withError error: Error) {
}
/**
 广告渲染成功
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
func ak_nativeExpressAdDidRenderSuccess(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
  // 渲染成功才能拿到真实的高度
  DispatchQueue.main.async(execute: { [self] in
                                     for _ in 0..<6 {
                                       dataArray.append(NSNull())
                                     }
                                     dataArray.append(adView)
                                     tableView?.reloadData()
                                    })
}
/**
 广告渲染失败
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
func ak_nativeExpressAdDidRenderFail(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
}
/**
 广告展现
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
func ak_nativeExpressAdDidShow(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
}
/**
 广告点击
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
func ak_nativeExpressAdDidClick(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
}
/**
 广告关闭
 @param nativeExpressAd 广告加载器实例
 @param adView 模板广告视图
 */
func ak_nativeExpressAdDidClose(_ nativeAd: AdKleinSDKNativeExpressAd, adView: UIView & AdKleinSDKNativeExpressAdViewDelegate){
  adView.removeFromSuperview()
  dataArray.removeAll { $0 as AnyObject === adView as AnyObject }
  tableView?.reloadData()
}
```



3. 执行广告加载器获取广告：

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

```swift
if (adLoader == nil) {
  adSize = CGSize(width: view.frame.size.width, height: 0)

  adLoader = AdKleinSDKNativeExpressAd(placementId: Constant.NATIVE_EXPRESS_ID, viewController: self)
  adLoader?.delegate = self
  adLoader?.adSize = adSize
  adLoader?.videoMuted = false
  adLoader?.adCount = 3
}

adLoader?.load()
```



### <a name="ad_reward_video">激励视频广告示例</a>

将短视频融入到APP场景当中，用户观看短视频广告后可以给予一些应用内奖励。

1. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKRewardVideoAd *adLoader;
```

```swift
var adLoader: AdKleinSDKRewardVideoAd?
```



2. 实现`AdKleinSDKRewardVideoAdDelegate`相关回调：

```objectivec
/**
 广告基础数据加载成功
 @param rewardVideoAd 广告加载器实例
*/
- (void)ak_rewardVideoAdDidLoad:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
}
/**
 广告加载失败
 @param rewardVideoAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_rewardVideoAdDidFail:(AdKleinSDKRewardVideoAd *)rewardVideoAd withError:(NSError *)error {
}
/**
 广告视频数据下载完成。
 在此回调后才可执行show方法。
 @param rewardVideoAd 广告加载器实例
*/
- (void)ak_rewardVideoAdDidDownload:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
  // 此处仅为示例用，表明在广告下载完之后才能执行展现，实际使用时建议提前加载视频，以提升用户体验
  [self.adView show];
}
/**
 广告播放中发生错误
 @param rewardVideoAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_rewardVideoAdDidRenderFail:(AdKleinSDKRewardVideoAd *)rewardVideoAd withError:(NSError *)error {
}
/**
 广告展示
 @param rewardVideoAd 广告加载器实例
*/
- (void)ak_rewardVideoAdDidShow:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
}
/**
 广告点击
 @param rewardVideoAd 广告加载器实例
*/
- (void)ak_rewardVideoAdDidClick:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
}
/**
 广告关闭
 @param rewardVideoAd 广告加载器实例
*/
- (void)ak_rewardVideoAdDidClose:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
}
/**
 完成奖励发放条件
 @param rewardVideoAd 广告加载器实例
*/
- (void)ak_rewardVideoAdDidRewardEffective:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
}
/**
 视频播放完成
 @param rewardVideoAd 广告加载器实例
*/
- (void)ak_rewardVideoAdDidComplete:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
}
/**
 点击跳过
 @param rewardVideoAd 广告加载器实例
*/
- (void)ak_rewardVideoAdDidSkip:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
}
```

```swift
/**
 广告基础数据加载成功
 @param rewardVideoAd 广告加载器实例
*/
func ak_rewardVideoAdDidLoad(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
}
/**
 广告加载失败
 @param rewardVideoAd 广告加载器实例
 @param error 错误描述
*/
func ak_rewardVideoAdDidFail(_ rewardVideoAd: AdKleinSDKRewardVideoAd, withError error: Error) {
}
/**
 广告视频数据下载完成。
 在此回调后才可执行show方法。
 @param rewardVideoAd 广告加载器实例
*/
func ak_rewardVideoAdDidDownload(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
  // 此处仅为示例用，表明在广告下载完之后才能执行展现，实际使用时建议提前加载视频，以提升用户体验
  adLoader?.show()
}
/**
 广告播放中发生错误
 @param rewardVideoAd 广告加载器实例
 @param error 错误描述
*/
func ak_rewardVideoAdDidRenderFail(_ rewardVideoAd: AdKleinSDKRewardVideoAd, withError error: Error) {
}
/**
 广告展示
 @param rewardVideoAd 广告加载器实例
*/
func ak_rewardVideoAdDidShow(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
}
/**
 广告点击
 @param rewardVideoAd 广告加载器实例
*/
func ak_rewardVideoAdDidClick(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
}
/**
 广告关闭
 @param rewardVideoAd 广告加载器实例
*/
func ak_rewardVideoAdDidClose(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
}
/**
 完成奖励发放条件
 @param rewardVideoAd 广告加载器实例
*/
func ak_rewardVideoAdDidRewardEffective(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
}
/**
 视频播放完成
 @param rewardVideoAd 广告加载器实例
*/
func ak_rewardVideoAdDidComplete(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
}
/**
 点击跳过
 @param rewardVideoAd 广告加载器实例
*/
func ak_rewardVideoAdDidSkip(_ rewardVideoAd: AdKleinSDKRewardVideoAd) {
}
```



3. 执行广告加载器获取广告：

```objectivec
self.adLoader = [[AdKleinSDKRewardVideoAd alloc] initWithPlacementId:CONST_REWARD_VIDEO_ID viewController:self];
self.adLoader.delegate = self;
[self.adLoader load];
```

```swift
adLoader = AdKleinSDKRewardVideoAd(placementId: Constant.REWARD_VIDEO_ID, viewController: self)
adLoader?.delegate = self
adLoader?.load()
```



### <a name="ad_fullscreen_video">全屏视频广告示例</a>

全屏视频广告是类似激励视频样式的广告形式，与激励视频不同之处在于全屏视频广告播放一定时间时间后即可跳过，同时全屏视频广告拥有跳过回调不具备奖励回调。

1. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKFullScreenVideoAd *adLoader;
```

```swift
var adLoader: AdKleinSDKFullScreenVideoAd?
```



2. 实现`AdKleinSDKFullScreenVideoAdDelegate`相关回调：

```objectivec
/**
 广告加载成功
 @param fullScreenVideoAd 广告加载器实例
*/
- (void)ak_fullScreenVideoAdDidLoad:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
  // 此处仅为示例用，表明在广告下载完之后才能执行展现，实际使用时建议提前加载广告，以提升用户体验
  [self.adLoader show];
}
/**
 广告加载失败
 @param fullScreenVideoAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_fullScreenVideoAdDidFail:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd withError:(NSError *)error{
}
/**
 广告展示
 @param fullScreenVideoAd 广告加载器实例
*/
- (void)ak_fullScreenVideoAdDidShow:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
}
/**
 广告点击
 @param fullScreenVideoAd 广告加载器实例
*/
- (void)ak_fullScreenVideoAdDidClick:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
}
/**
 广告关闭
 @param fullScreenVideoAd 广告加载器实例
*/
- (void)ak_fullScreenVideoAdDidClose:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
}
/**
 视频播放完成
 @param fullScreenVideoAd 广告加载器实例
*/
- (void)ak_fullScreenVideoAdDidComplete:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
}
/**
 点击跳过
 @param fullScreenVideoAd 广告加载器实例
*/
- (void)ak_fullScreenVideoAdDidSkip:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
}
```

```swift
/**
 广告加载成功
 @param fullScreenVideoAd 广告加载器实例
*/
func ak_fullScreenVideoAdDidLoad(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
  // 此处仅为示例用，表明在广告下载完之后才能执行展现，实际使用时建议提前加载广告，以提升用户体验
  adLoader?.show()
}
/**
 广告加载失败
 @param fullScreenVideoAd 广告加载器实例
 @param error 错误描述
*/
func ak_fullScreenVideoAdDidFail(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd, withError error: Error) {
}
/**
 广告展示
 @param fullScreenVideoAd 广告加载器实例
*/
func ak_fullScreenVideoAdDidShow(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
}
/**
 广告点击
 @param fullScreenVideoAd 广告加载器实例
*/
func ak_fullScreenVideoAdDidClick(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
}
/**
 广告关闭
 @param fullScreenVideoAd 广告加载器实例
*/
func ak_fullScreenVideoAdDidClose(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
}
/**
 视频播放完成
 @param fullScreenVideoAd 广告加载器实例
*/
func ak_fullScreenVideoAdDidComplete(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
}
/**
 点击跳过
 @param fullScreenVideoAd 广告加载器实例
*/
func ak_fullScreenVideoAdDidSkip(_ fullScreenVideoAd: AdKleinSDKFullScreenVideoAd) {
}
```



3. 执行广告加载器获取广告：

```objectivec
self.adLoader = [[AdKleinSDKFullScreenVideoAd alloc] initWithPlacementId:CONST_FULLSCREEN_ID viewController:self];
self.adLoader.delegate = self;
self.adLoader.detailPageVideoMuted = YES;
self.adLoader.videoAutoPlayOnWWAN = YES;
self.adLoader.minVideoDuration = 5;
self.adLoader.maxVideoDuration = 100*1000;
[self.adLoader load];
```

```swift
adLoader = AdKleinSDKFullScreenVideoAd(placementId: Constant.FULLSCREEN_ID, viewController: self)
adLoader?.delegate = self
adLoader?.detailPageVideoMuted = true
adLoader?.videoAutoPlayOnWWAN = true
adLoader?.minVideoDuration = 5
adLoader?.maxVideoDuration = 100 * 1000
adLoader?.load()
```



### <a name="ad_interstitial">插屏广告示例</a>

插屏广告是移动广告的一种常见形式，在应用流程中弹出，当应用展示插屏广告时，用户可以选择点击广告，也可以将其关闭并返回应用。

1. 声明广告加载器：

```objectivec
@property(nonatomic, strong) AdKleinSDKInterstitialAd *adLoader;
```

```swift
var adLoader: AdKleinSDKInterstitialAd?
```



2. 实现`AdKleinSDKInterstitialAdDelegate`相关回调：

```objectivec
/**
 广告拉取成功
 @param interstitialAd 广告加载器实例
*/
- (void)ak_interstitialAdDidLoad:(AdKleinSDKInterstitialAd *)interstitialAd {
  // 此处仅为示例用，表明在广告下载完之后才能执行展现，实际使用时建议提前加载广告，以提升用户体验
  [self.adLoader show];
}
/**
 广告拉取失败
 @param interstitialAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_interstitialAdDidFail:(AdKleinSDKInterstitialAd *)interstitialAd withError:(NSError *)error {
}
/**
 广告渲染成功
 @param interstitialAd 广告加载器实例
*/
- (void)ak_interstitialAdDidRenderSuccess:(AdKleinSDKInterstitialAd *)interstitialAd {
}
/**
 广告渲染失败
 @param interstitialAd 广告加载器实例
 @param error 错误描述
*/
- (void)ak_interstitialAdDidRenderFail:(AdKleinSDKInterstitialAd *)interstitialAd withError:(NSError *)error {
}
/**
 广告展示
 @param interstitialAd 广告加载器实例
*/
- (void)ak_interstitialAdDidShow:(AdKleinSDKInterstitialAd *)interstitialAd {
}
/**
 广告点击
 @param interstitialAd 广告加载器实例
*/
- (void)ak_interstitialAdDidClick:(AdKleinSDKInterstitialAd *)interstitialAd{
}
/**
 广告关闭
 @param interstitialAd 广告加载器实例
*/
- (void)ak_interstitialAdDidClose:(AdKleinSDKInterstitialAd *)interstitialAd {
}
```

```swift
/**
 广告拉取成功
 @param interstitialAd 广告加载器实例
*/
func ak_interstitialAdDidLoad(_ interstitialAd: AdKleinSDKInterstitialAd) {
// 此处仅为示例用，表明在广告下载完之后才能执行展现，实际使用时建议提前加载广告，以提升用户体验
  adLoader?.show()
}
/**
 广告拉取失败
 @param interstitialAd 广告加载器实例
 @param error 错误描述
*/
func ak_interstitialAdDidFail(_ interstitialAd: AdKleinSDKInterstitialAd, withError error: Error) {
}
/**
 广告渲染成功
 @param interstitialAd 广告加载器实例
*/
func ak_interstitialAdDidRenderSuccess(_ interstitialAd: AdKleinSDKInterstitialAd) {
}
/**
 广告渲染失败
 @param interstitialAd 广告加载器实例
 @param error 错误描述
*/
func ak_interstitialAdDidRenderFail(_ interstitialAd: AdKleinSDKInterstitialAd, withError error: Error) {
}
/**
 广告展示
 @param interstitialAd 广告加载器实例
*/
func ak_interstitialAdDidShow(_ interstitialAd: AdKleinSDKInterstitialAd) {
}
/**
 广告点击
 @param interstitialAd 广告加载器实例
*/
func ak_interstitialAdDidClick(_ interstitialAd: AdKleinSDKInterstitialAd) {
}
/**
 广告关闭
 @param interstitialAd 广告加载器实例
*/
func ak_interstitialAdDidClose(_ interstitialAd: AdKleinSDKInterstitialAd) {
}
```



3. 执行广告加载器获取广告：

```objectivec
self.adLoader = [[AdKleinSDKInterstitialAd alloc] initWithPlacementId:CONST_INTERSTITIAL_ID viewController:self];
self.adLoader.delegate = self;
self.adLoader.adSize = CGSizeMake(300, 400);
[self.adLoader load];
```

```swift
adLoader = AdKleinSDKInterstitialAd(placementId: Constant.INTERSTITIAL_ID, viewController: self)
adLoader?.delegate = self
adLoader?.adSize = CGSize(width: 300, height: 400)
adLoader?.load()
```



## iOS集成常见问题

### 通用问题

#### 运行时报错'building for iOS Simulator, but linking in object file built for iOS, for architecture arm64'

请检查以下配置：

- 升级Cocoapods到1.10.x以上
- 在应用Project的Target下，`Architectures`为默认值`$(ARCHS_STANDARD)`
- `Build Active Architecture Only`(`ONLY_ACTIVE_ARCH`)值为Yes
- 删除`Valid Architectures`(`VALID_ARCHS`)配置项
- 在Podfile文件末尾添加
```
post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
```
然后清理缓存和Pods文件夹，并重新执行`pod install`

#### 为什么返回的广告中有重复广告？

同一个广告主在广告后台会使用相似的素材内容创建多个广告计划，因此平台在返回的广告中可能会有很多相似内容的广告，但是这些广告对应的广告计划ID是不相同的。

### 开屏广告常见问题

#### 开屏广告的容器需要注意什么？

**开屏广告的高度必须大于等于屏幕高度（手机屏幕完整高度，包括状态栏）的75%**，否则可能会影响收益计费（广点通的开屏甚至会影响跳过按钮的回调）。

#### 广点通开屏在3秒后直接关闭且未触发关闭回调、穿山甲开屏点击跳过或者倒计时结束时广告不会移除

开屏广告对象在创建后需要用本地变量保存以继续持有，否则会被提前释放，导致此类问题。

### 横幅广告常见问题

#### Banner横幅广告的尺寸问题？

Banner广告支持多种尺寸比例，可在后台创建广告位时配置，Banner广告的宽度将会撑满容器，高度自适应，建议Banner广告容器高度也为自适应。

#### Banner横幅广告的建议位置

Banner横幅广告建议放置在 **固定位置**，而非TableView等控件中充当Cell。

### 信息流广告常见问题

#### 信息流广告中自渲染和模板的区别

信息流广告，具备自渲染和模板两种广告样式：自渲染是SDK将返回广告标题、描述、Icon、图片、多媒体视图等信息，开发者可通过自行拼装渲染成喜欢的样式；模板样式则是返回拼装好的广告视图，开发者只需将视图添加到相应容器即可，模板样式的容器高度建议是自适应

### 激励视频、全屏视频、插屏广告常见问题

**激励视频广告**是播放一段视频，播放完成或其他特定情况下（不同平台有所差异）会给予激励回调，激励视频一般是需要播放完成后才能退出播放界面；**全屏视频广告**类似激励视频，但是全屏视频没有激励回调，全屏视频一般在播放一段时间后即可退出当前播放界面；**插屏广告**一般是以弹窗的形式展示图文或视频，也有部分平台是单独的全屏界面进行展示；



## iOS SDK错误码



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



## 更新日志

| 版本号  |    日期    | 更新日志                                                     |
| ------- | :--------: | ------------------------------------------------------------ |
| v3.2.0 | 2021-08-31 | 优化横幅广告，请注意接入方式变更； |
| v3.1.0 | 2021-07-30 | 更新AdMobiusSDK； |
| V3.0.1 | 2021-06-25 | 3.0全新发布，产品更名为AdKleinSDK，支持Cocoapods在线安装，2.x版本用户请注意接入代码更新； |
