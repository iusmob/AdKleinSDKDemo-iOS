//
//  AppDelegate.m
//  Demo
//
//  Created by mac on 2020/8/11.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ConstantsHeader.h"
#import <AdKleinSDK/AdKleinSDK.h>
#import <Bugly/Bugly.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
#import "HDWindowLogger.h"
#import "PrivacyAlert.h"


@interface AppDelegate () <AdKleinSDKSplashAdDelegate>
@property (nonatomic, strong) AdKleinSDKSplashAd *splashAd;
@property (nonatomic, strong) UIView *markView;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [ViewController new];
    [self.window makeKeyAndVisible];
  
    [self initSDK];
    // 开屏会在初始化完成后执行
    [self loadSplashAd];
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if (self.splashAd) {
        // 已存在开屏广告
        return;
    }
    NSDate *now = [NSDate date];
    NSDate *lastSplashTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSplashTime"];
    int interval = (int)ceil([now timeIntervalSinceDate:lastSplashTime]);
    if (interval < 20) {
        NSLog(@"距离上次开屏间隔小于20秒，不发起开屏");
        return;
    }
    [self loadSplashAd];
}

- (void)initSDK {
    [self initBugly];
    [self initWindowLogger];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([[userDefault objectForKey:@"inited"] isEqualToString:@"YES"]) {
        [self initAdKleinSDK];
    }else {
        [self showPrivacyAlert];
    }
}

- (void)initWindowLogger {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HDWindowLogger show];
        [HDWindowLogger hide];
        UIView *fv = [[HDWindowLogger defaultWindowLogger] valueForKey:@"mFloatWindow"];
        fv.hidden = NO;
        CGRect frame = fv.frame;
        frame.origin.y = UIScreen.mainScreen.bounds.size.height - 200;
        fv.frame = frame;
    });
}

- (void)initBugly {
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.unexpectedTerminatingDetectionEnable = YES; //非正常退出事件记录开关，默认关闭
    config.reportLogLevel = BuglyLogLevelWarn; //报告级别
    config.blockMonitorEnable = YES; //开启卡顿监控
    config.blockMonitorTimeout = 5; //卡顿监控判断间隔，单位为秒
    [Bugly startWithAppId:@"b393fcad77"];
}

- (void)showPrivacyAlert {
    PrivacyAlert *alert = [[PrivacyAlert alloc]init];
    [alert showOnComplete:^(BOOL result) {
        if (result) {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:@"YES" forKey:@"inited"];
            [userDefault synchronize];
            // IOS14新增，需要先申请IDFA，否则会影响收益
            if (@available(iOS 14.0, *)) {
                [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                }];
            }
            [self initAdKleinSDK];
        } else {
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [UIView animateWithDuration:0.5f animations:^{
                self.window.alpha = 0;
                self.window.frame = CGRectMake(0, self.window.bounds.size.height / 2, self.window.bounds.size.width, 0.5);
            } completion:^(BOOL finished) {
                exit(0);
            }];
        }
    }];
}

- (void)initAdKleinSDK {
    [AdKleinSDKConfig debugMode];
//    [AdKleinSDKConfig initMediaId:CONST_MEDIA_ID];
    [AdKleinSDKConfig initMediaId:CONST_MEDIA_ID onComplete:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"SDK 初始化失败");
        } else {
            NSLog(@"SDK 初始化成功");
        }
    }];
}

- (void)loadSplashAd {
    self.splashAd = [[AdKleinSDKSplashAd alloc] initWithPlacementId:CONST_SPLASH_ID window:self.window];
    self.splashAd.delegate = self;
    [self.splashAd load];
}

#pragma mark - AdKleinSDKSplashAdDelegate
- (void)ak_splashAdDidSkip:(AdKleinSDKSplashAd *)splashAd {
}
- (void)ak_splashAdTimeOver:(AdKleinSDKSplashAd *)splashAd {
}
- (void)ak_splashAdDidFail:(AdKleinSDKSplashAd *)splashAd withError:(NSError *)error {
    self.splashAd = nil;
}
- (void)ak_splashAdDidLoad:(AdKleinSDKSplashAd *)splashAd {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSDate date] forKey:@"lastSplashTime"];
    [userDefault synchronize];
}
- (void)ak_splashAdDidShow:(AdKleinSDKSplashAd *)splashAd {
}
- (void)ak_splashAdDidClick:(AdKleinSDKSplashAd *)splashAd {

}
- (void)ak_splashAdDidClose:(AdKleinSDKSplashAd *)splashAd {
    self.splashAd = nil;
}

@end
