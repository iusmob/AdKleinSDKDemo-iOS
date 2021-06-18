//
//  RewardVideoVC.m
//  AdKleinSDK_Example
//
//  Created by mac on 2020/8/10.
//  Copyright © 2020 yantl0. All rights reserved.
//

#import "RewardVideoVC.h"
#import <AdKleinSDK/AdKleinSDKRewardVideoAd.h>

@interface RewardVideoVC () <AdKleinSDKRewardVideoAdDelegate>
@property (nonatomic, strong) AdKleinSDKRewardVideoAd *adView;


@end

@implementation RewardVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadClick {
    if (self.adView) {
        self.adView.delegate = nil;
        self.adView = nil;
    }
    self.adView = [[AdKleinSDKRewardVideoAd alloc] initWithPlacementId:CONST_REWARD_VIDEO_ID viewController:self];
    self.adView.delegate = self;
    [self.adView load];
}

- (void)showClick {
    [self.adView show];
}

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


@end
