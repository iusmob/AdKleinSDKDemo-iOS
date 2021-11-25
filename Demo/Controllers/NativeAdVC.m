//
//  NativeAdVC.m
//  Demo
//
//  Created by mirari on 2021/5/11.
//  Copyright © 2021 MobiusAd. All rights reserved.
//

#import "NativeAdVC.h"

@interface NativeAdVC () <AdKleinSDKNativeAdDelegate>

@property(nonatomic, strong) AdKleinSDKNativeAd *adLoader;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, assign) CGFloat adY;
@property(nonatomic, strong) NSMutableArray *adViews;
@property (strong, nonatomic) UIButton *removeBtn;

@end

@implementation NativeAdVC

- (void)onChangeSlotId:(NSNotification *)notification
{
    [self removeClick];
    self.adLoader = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.slotIdTextField.text = CONST_NATIVE_ID;

    self.showBtn.hidden = YES;

    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    self.removeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 320, screen_width - 40, 40)];
    [self.removeBtn setTitle:@"remove" forState:UIControlStateNormal];
    [self.removeBtn addTarget:self action:@selector(removeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.removeBtn];
    self.removeBtn.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3];

    self.adY = 50;
    self.adViews = [NSMutableArray new];
    CGSize size = self.view.frame.size;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, size.width, size.height-100)];
    [self.view addSubview:self.scrollView];
    [self.view sendSubviewToBack:self.scrollView];
}

- (void)loadClick {
    if(!self.adLoader) {
        self.adLoader = [[AdKleinSDKNativeAd alloc] initWithPlacementId:self.slotIdTextField.text viewController:self];
        self.adLoader.delegate = self;
        self.adLoader.adCount = 3;
    }
    [self.adLoader load];
}

- (void)removeClick {
    for (id adView in self.adViews.mutableCopy) {
        if([adView conformsToProtocol:@protocol(AdKleinSDKNativeAdViewDelegate)]) {
            // 取消注册
            [(id<AdKleinSDKNativeAdViewDelegate>)adView ak_unRegistView];
            [adView removeFromSuperview];
        }
    }
    self.adViews = [NSMutableArray new];
    self.adY = 50;
}

- (void)ak_nativeAdDidLoad:(AdKleinSDKNativeAd *)nativeAd withAdViews:(NSArray<__kindof UIView<AdKleinSDKNativeAdViewDelegate> *> *)adViews {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];

    for (UIView<AdKleinSDKNativeAdViewDelegate> *adView in adViews) {
        [self.adViews addObject:adView];

        CGFloat width = self.scrollView.frame.size.width;
        CGFloat height = 300;
        adView.frame = CGRectMake(0, self.adY, width, height);
        adView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.9 alpha:0.3];
        [self.scrollView addSubview:adView];
        self.adY += height+20;
        self.scrollView.contentSize = CGSizeMake(width, self.adY+100);

        AdKleinSDKNativeAdData *nativeAdData = adView.data;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, width-30, 20)];
        title.text = nativeAdData.title;
        [adView addSubview:title];

        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, width-30, 40)];
        desc.text = nativeAdData.desc;
        [adView addSubview:desc];

        // 展示关闭按钮
        UIButton *closeButton = [UIButton new];
        [adView addSubview:closeButton];
        [adView bringSubviewToFront:closeButton];
        closeButton.frame = CGRectMake(width - 80, 0, 80, 44);
        [closeButton setTitle:@"remove" forState:UIControlStateNormal];
        [closeButton addTarget:adView action:@selector(ak_close) forControlEvents:UIControlEventTouchUpInside];

        NSLog(@"AdKleinSDKDemo: NativeAd Mode = %lu", (unsigned long)nativeAdData.imageMode);

        switch (nativeAdData.imageMode) {
            case AK_NATIVE_AD_LARGE_IMAGE:
                {
                    UIImageView *single = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, width-30, 200)];
                    [adView addSubview:single];
                    single.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[0]]]];
                    [adView ak_registViews:@[title, desc, single]];
                }
                break;
            case AK_NATIVE_AD_SMALL_IMAGE:
                {
                    UIImageView *single = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, width-30, 200)];
                    [adView addSubview:single];
                    single.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[0]]]];
                    [adView ak_registViews:@[title, desc, single]];
                }
                break;
            case AK_NATIVE_AD_THREE_SMALL:
                {
                    CGFloat imageWidth = (width - 16) / 3;
                    CGFloat imageRate = 228 / 150.0; // 三小图默认比例
                    UIImageView *imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 84, imageWidth, imageWidth / imageRate)];
                    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(16 + imageWidth, 84, imageWidth, imageWidth / imageRate)];
                    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(24 + imageWidth * 2, 84, imageWidth, imageWidth / imageRate)];

                    [adView addSubview:imageView0];
                    [adView addSubview:imageView1];
                    [adView addSubview:imageView2];
                    imageView0.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[0]]]];
                    imageView1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[1]]]];
                    imageView2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nativeAdData.images[2]]]];
                    [adView ak_registViews:@[title, desc, imageView0, imageView1, imageView2]];
                }
                break;
            case AK_NATIVE_AD_VIDEO:
            {
                UIView *video = adView.mediaView;
                video.frame = CGRectMake(15, 70, width-30, 200);
                [adView addSubview:video];
                [adView ak_registViews:@[title, desc, video]];
            }
                break;

            default:
                break;
        }
    }
}

- (void)ak_nativeAdDidFail:(AdKleinSDKNativeAd *)nativeAd withError:(NSError *)error {
    [self showError:error];
}
- (void)ak_nativeAdDidShow:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_nativeAdDidClick:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
}
- (void)ak_nativeAdDidClose:(AdKleinSDKNativeAd *)nativeAd adView:(__kindof UIView<AdKleinSDKNativeAdViewDelegate> *)adView {
    NSString *func = [NSString stringWithFormat:@"%s",__func__];
    [self showString:func];
    [self.adViews removeObject:adView];
}
@end
