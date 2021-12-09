//
//  FullScreenVideoVC.m
//  Demo
//
//  Created by mac on 2020/8/13.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#import "FullScreenVideoVC.h"

@interface FullScreenVideoVC () <AdKleinSDKFullScreenVideoAdDelegate>

@property (nonatomic, strong) AdKleinSDKFullScreenVideoAd *adLoader;


@end

@implementation FullScreenVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.slotIdTextField.text = CONST_FULLSCREEN_ID;
}


- (void)loadClick {
    if (self.adLoader) {
        self.adLoader.delegate = nil;
        self.adLoader = nil;
    }
    self.adLoader = [[AdKleinSDKFullScreenVideoAd alloc] initWithPlacementId:self.slotIdTextField.text viewController:self];
    self.adLoader.delegate = self;
    [self.adLoader load];
}

- (void)showClick {
    [self.adLoader show];
}

- (void)ak_fullScreenVideoAdDidLoad:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_fullScreenVideoAdDidFail:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd withError:(NSError *)error{
    [self showError:error];
}
- (void)ak_fullScreenVideoAdDidDownload:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
    [self.adLoader show];
}
- (void)ak_fullScreenVideoAdDidRenderSuccess:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_fullScreenVideoAdDidRenderFail:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd withError:(NSError *)error{
    [self showError:error];
}
- (void)ak_fullScreenVideoAdDidShow:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_fullScreenVideoAdDidClick:(AdKleinSDKFullScreenVideoAd *)fullScreenVideoAd {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
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


@end
