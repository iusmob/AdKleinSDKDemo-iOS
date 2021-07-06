//
//  SplashAdVC.m
//  AdKleinSDK_Example
//
//  Created by mac on 2020/8/10.
//  Copyright © 2020 yantl0. All rights reserved.
//

#import "SplashAdVC.h"
#import <AdKleinSDK/AdKleinSDKSplashAd.h>
//#import "ConfigureManager.h"


@interface SplashAdVC ()<AdKleinSDKSplashAdDelegate>

@property (nonatomic, strong) AdKleinSDKSplashAd *splashAd;

@property (nonatomic,strong) UIImageView * bottomView;

@property (nonatomic,strong) UIButton * skipView;



@property (nonatomic,assign) BOOL isBottom;
@property (nonatomic,strong) UILabel *bottomLabel;
@property (nonatomic,strong) UISwitch *customBottomSwitch;

@property (nonatomic,assign) BOOL isSkip;
@property (nonatomic,strong) UILabel *skipLabel;
@property (nonatomic,strong) UISwitch *customSkipSwitch;

@end

@implementation SplashAdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.showBtn.hidden = YES;



    self.customSkipSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(150,self.loadBtn.frame.origin.y + 100,50,40)];
    self.customSkipSwitch.on = NO;
    [self.customSkipSwitch addTarget:self action:@selector(customSkipSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customSkipSwitch];

    self.skipLabel = [[UILabel alloc]initWithFrame:CGRectMake(50,self.loadBtn.frame.origin.y + 100, 80, 40)];
    self.skipLabel.text = @"跳过按钮";
    [self.view addSubview:self.skipLabel];



    self.customBottomSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(150, self.loadBtn.frame.origin.y+200,50, 40)];
    self.customBottomSwitch.on = NO;
    [self.customBottomSwitch addTarget:self action:@selector(customBottomSwitchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBottomSwitch];

    self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(50,self.loadBtn.frame.origin.y + 200, 80, 40)];
    self.bottomLabel.text = @"底部View";
    [self.view addSubview:self.bottomLabel];
}

- (void)loadClick {
    if (self.splashAd) {
        self.splashAd.delegate = nil;
        self.splashAd = nil;
    }
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.splashAd = [[AdKleinSDKSplashAd alloc] initWithPlacementId:CONST_SPLASH_ID window:window];
    self.splashAd.delegate = self;


    if (self.isSkip) {
        //自定义跳过按钮  非必须
        _skipView = [[UIButton alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 80, [[UIScreen mainScreen] bounds].size.height - 80, 60, 30)];
        [_skipView addTarget:self action:@selector(skipViewClick) forControlEvents:UIControlEventTouchUpInside];
        [_skipView setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipView.layer setCornerRadius:15.0];
        _skipView.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        _skipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
        self.splashAd.skipView = self.skipView;
    }

    if (self.isBottom) {
        //自定义底部view  非必须
        _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,[UIScreen mainScreen].bounds.size.height*0.25)];
        _bottomView.image = [UIImage imageNamed:@"bottom"];
        _bottomView.contentMode = UIViewContentModeScaleAspectFill;
        self.splashAd.bottomView = _bottomView;
    }
    [self.splashAd load];


}


- (void)skipViewClick {
    [self.splashAd removeSplashAd];
}

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
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSDate date] forKey:@"lastSplashTime"];
    [userDefault synchronize];
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

- (void)customSkipSwitchClick:(UISwitch *)sw {
    if (sw.on) {
        self.isSkip = YES;
    }else {
        self.isSkip = NO;
    }
}


- (void)customBottomSwitchClick:(UISwitch *)sw {
    if (sw.on) {
        self.isBottom = YES;
    }else {
        self.isBottom = NO;
    }
}

@end
