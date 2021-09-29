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
#import "PrivacyAlert.h"


@interface AppDelegate () <AdKleinSDKSplashAdDelegate>
@property (nonatomic, strong) AdKleinSDKSplashAd *splashAd;
@property (nonatomic, strong) UIView *placeholderView;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.rootViewController = [ViewController new];
	[self.window makeKeyAndVisible];

	[self createPlaceholder];
	[self initSDK];
	return YES;
}

- (void)initSDK {
	[self initBugly];

	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	if ([[userDefault objectForKey:@"inited"] isEqualToString:@"YES"]) {
		[self initAdKleinSDK];
	}else {
		[self showPrivacyAlert];
	}
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
			 if (@available(iOS 14.0, *)) {
				 [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
				          dispatch_async(dispatch_get_main_queue(), ^{
								 [self initAdKleinSDK];
							 });
				  }];
			 } else {
                 [self initAdKleinSDK];
             }
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
	[self loadSplashAd];
}

- (void)loadSplashAd {
	if (!self.splashAd) {
		self.splashAd = [[AdKleinSDKSplashAd alloc] initWithPlacementId:CONST_SPLASH_ID window:self.window];
		self.splashAd.delegate = self;
	}
	[self.splashAd load];
}

- (void)createPlaceholder {
	NSString *lsname = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UILaunchStoryboardName"];
	UIViewController *vc = [[UIStoryboard storyboardWithName:lsname bundle:nil] instantiateInitialViewController];
	vc.view.frame = self.window.bounds;
	[self.window addSubview:vc.view];
	self.placeholderView = vc.view;
}

- (void)removePlaceholder {
	if (self.placeholderView) {
		[self.placeholderView removeFromSuperview];
	}
}

#pragma mark - AdKleinSDKSplashAdDelegate
- (void)ak_splashAdDidSkip:(AdKleinSDKSplashAd *)splashAd {
}
- (void)ak_splashAdTimeOver:(AdKleinSDKSplashAd *)splashAd {
}
- (void)ak_splashAdDidFail:(AdKleinSDKSplashAd *)splashAd withError:(NSError *)error {
	[self removePlaceholder];
}
- (void)ak_splashAdDidLoad:(AdKleinSDKSplashAd *)splashAd {
}
- (void)ak_splashAdDidShow:(AdKleinSDKSplashAd *)splashAd {
	[self removePlaceholder];
}
- (void)ak_splashAdDidClick:(AdKleinSDKSplashAd *)splashAd {

}
- (void)ak_splashAdDidClose:(AdKleinSDKSplashAd *)splashAd {
}

@end
