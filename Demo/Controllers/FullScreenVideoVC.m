//
//  FullScreenVideoVC.m
//  Demo
//
//  Created by mac on 2020/8/13.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "FullScreenVideoVC.h"

@interface FullScreenVideoVC () <AdKleinSDKFullScreenVideoAdDelegate>

@property (nonatomic, strong) AdKleinSDKFullScreenVideoAd *adView;


@end

@implementation FullScreenVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}


- (void)loadClick {
    if (self.adView) {
        self.adView.delegate = nil;
        self.adView = nil;
    }
    self.adView = [[AdKleinSDKFullScreenVideoAd alloc] initWithPlacementId:CONST_FULLSCREEN_ID viewController:self];
    self.adView.delegate = self;
    self.adView.detailPageVideoMuted = YES;
    self.adView.videoAutoPlayOnWWAN = YES;
    self.adView.minVideoDuration = 5;
    self.adView.maxVideoDuration = 100*1000;
    [self.adView load];
}

- (void)showClick {
    [self.adView show];
}


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



@end