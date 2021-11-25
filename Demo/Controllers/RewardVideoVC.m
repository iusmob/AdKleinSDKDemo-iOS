//
//  RewardVideoVC.m
//  AdKleinSDK_Example
//
//  Created by mac on 2020/8/10.
//  Copyright © 2020 yantl0. All rights reserved.
//

#import "RewardVideoVC.h"

@interface RewardVideoVC () <AdKleinSDKRewardVideoAdDelegate>
@property (nonatomic, strong) AdKleinSDKRewardVideoAd *adLoader;


@end

@implementation RewardVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.slotIdTextField.text = CONST_REWARD_VIDEO_ID;
}

- (void)loadClick {
    if (self.adLoader) {
        self.adLoader.delegate = nil;
        self.adLoader = nil;
    }
    self.adLoader = [[AdKleinSDKRewardVideoAd alloc] initWithPlacementId:self.slotIdTextField.text viewController:self];
    self.adLoader.delegate = self;
    [self.adLoader load];
}

- (void)showClick {
    [self.adLoader show];
}


- (void)ak_rewardVideoAdDidLoad:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}

- (void)ak_rewardVideoAdDidFail:(AdKleinSDKRewardVideoAd *)rewardVideoAd withError:(NSError *)error {
    [self showError:error];
}

- (void)ak_rewardVideoAdDidDownload:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
    [self.adLoader show];
}

- (void)ak_rewardVideoAdDidRenderSuccess:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}

- (void)ak_rewardVideoAdDidRenderFail:(AdKleinSDKRewardVideoAd *)rewardVideoAd withError:(NSError *)error {
    [self showError:error];
}

- (void)ak_rewardVideoAdDidShow:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}

- (void)ak_rewardVideoAdDidClick:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}

- (void)ak_rewardVideoAdDidClose:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}

- (void)ak_rewardVideoAdDidRewardEffective:(AdKleinSDKRewardVideoAd *)rewardVideoAd {
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

@end
