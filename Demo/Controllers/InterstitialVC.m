//
//  UnifiedInterstitialVC.m
//  Demo
//
//  Created by mac on 2020/8/13.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "InterstitialVC.h"

@interface InterstitialVC () <AdKleinSDKInterstitialAdDelegate>

@property (nonatomic, strong) AdKleinSDKInterstitialAd *adLoader;


@end

@implementation InterstitialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showBtn.hidden = YES;
}


- (void)loadClick {
    if (self.adLoader) {
        self.adLoader.delegate = nil;
        self.adLoader = nil;
    }
    self.adLoader = [[AdKleinSDKInterstitialAd alloc] initWithPlacementId:CONST_INTERSTITIAL_ID viewController:self];
    self.adLoader.delegate = self;
    self.adLoader.adSize = CGSizeMake(300, 400);
    [self.adLoader load];
}

- (void)ak_interstitialAdDidLoad:(AdKleinSDKInterstitialAd *)interstitialAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
    [self.adLoader show];
}
- (void)ak_interstitialAdDidFail:(AdKleinSDKInterstitialAd *)interstitialAd withError:(NSError *)error {
    [self showError:error];
}
- (void)ak_interstitialAdDidRenderSuccess:(AdKleinSDKInterstitialAd *)interstitialAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_interstitialAdDidRenderFail:(AdKleinSDKInterstitialAd *)interstitialAd withError:(NSError *)error {
    [self showError:error];
}
- (void)ak_interstitialAdDidShow:(AdKleinSDKInterstitialAd *)interstitialAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_interstitialAdDidClick:(AdKleinSDKInterstitialAd *)interstitialAd{
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_interstitialAdDidClose:(AdKleinSDKInterstitialAd *)interstitialAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}

@end
