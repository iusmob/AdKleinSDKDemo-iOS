//
//  BannerViewVC.m
//  AdKleinSDK_Example
//
//  Created by mac on 2020/8/10.
//  Copyright © 2020 yantl0. All rights reserved.
//

#import "BannerViewVC.h"
#import <AdKleinSDK/AdKleinSDKBannerAd.h>

@interface BannerViewVC () <AdKleinSDKBannerAdDelegate>
@property (nonatomic, strong) AdKleinSDKBannerAd *adView;

@property (strong, nonatomic) UIButton *removeBtn;

@end

@implementation BannerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.showBtn.hidden = YES;

    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;

    self.removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, screen_width - 100, 50)];
    [self.removeBtn setTitle:@"remove" forState:UIControlStateNormal];
    [self.removeBtn addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.removeBtn];
    self.removeBtn.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3];
}

- (void)loadClick {
    if (self.adView) {
        self.adView.delegate = nil;
        self.adView = nil;
    }
    self.adView = [[AdKleinSDKBannerAd alloc] initWithPlacementId:CONST_BANNER_ID viewController:self];
    self.adView.delegate = self;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    self.adView.bannerFrame = CGRectMake(0, 400, screen_width, screen_width / 2);
    self.adView.adContainer = self.view;
    self.adView.animated = YES;
    //self.adView.autoSwitchInterval = 10;

    [self.adView load];

}

- (void)removeClick {
    if (self.adView) {
        [self.adView removeAd];
        self.adView.delegate = nil;
        self.adView = nil;
    }
}

#pragma mark 协议方法
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
