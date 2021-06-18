//
//  UnifiedInterstitialVC.m
//  Demo
//
//  Created by mac on 2020/8/13.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "InterstitialVC.h"
#import <AdKleinSDK/AdKleinSDKInterstitialAd.h>


@interface InterstitialVC () <AdKleinSDKInterstitialAdDelegate>

@property (nonatomic, strong) AdKleinSDKInterstitialAd *adView;


@end

@implementation InterstitialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showBtn.hidden = YES;
}


- (void)loadClick {
    if (self.adView) {
        self.adView.delegate = nil;
        self.adView = nil;
    }
    self.adView = [[AdKleinSDKInterstitialAd alloc] initWithPlacementId:CONST_INTERSTITIAL_ID viewController:self];
    self.adView.delegate = self;
    self.adView.adSize = CGSizeMake(300, 400);
    [self.adView load];
}

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

@end
